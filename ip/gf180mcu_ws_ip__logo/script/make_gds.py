# SPDX-FileCopyrightText: © 2024 Leo Moser <leo.moser@pm.me>
# SPDX-License-Identifier: Apache-2.0

import klayout.db as db
import argparse
from PIL import Image


def convert_to_gds(
    input_filepath,
    output_filepath,
    cellname="TOP",
    scale=1.0,
    width=None,
    height=None,
    threshold=128,
    invert=False,
    invert_alpha=False,
    merge=False,
    smooth=False,
    pixel_size=6,
    foregrounds=["1/0"],
    boundaries=["0/0"],
):

    ly = db.Layout()
    ly.dbu = 0.001

    top = ly.create_cell(cellname)
    to_um = db.CplxTrans(ly.dbu)
    from_um = to_um.inverted()

    # Open the image
    img = Image.open(input_filepath)

    # Add the foregrounds
    foreground_layers = []
    for foreground in foregrounds:
        layer, datatype = foreground.split('/')
        foreground_layer = db.LayerInfo(int(layer), int(datatype))
        foreground_layers.append(foreground_layer)

    if not invert_alpha:
        # Create a white rgba background
        new_image = Image.new("RGBA", img.size, "WHITE")
    else:
        # Create a black rgba background
        new_image = Image.new("RGBA", img.size, "BLACK")

    # Paste the image on the background
    new_image.paste(img, (0, 0), img)

    # Convert the image to grayscale
    new_image_grayscale = new_image.convert("L")

    # new_image_grayscale.show()

    # Convert the image to binary
    new_image_binary = new_image_grayscale.point(lambda x: 255 if x > threshold else 0)
    new_image_binary = new_image_binary.convert("1")

    # new_image_binary.show()

    # Scale down the image
    if scale != 1.0:
        new_image_binary.thumbnail(
            (new_image_binary.width * scale, new_image_binary.height * scale),
            Image.LANCZOS,
        )

    if width or height:
        new_image_binary.thumbnail(
            (width, height),
            Image.LANCZOS,
        )

    # Use a region to merge pixels together
    if merge:
        top_region = db.Region()

    for y in range(new_image_binary.height):
        for x in range(new_image_binary.width):
            # If pixel is set
            pixel = new_image_binary.getpixel((x, y))

            if pixel and not invert or not pixel and invert:
                pixel = db.DBox(0.0, 0.0, pixel_size, pixel_size).moved(
                    x * pixel_size, (new_image_binary.height - y - 1) * pixel_size
                )

                if merge:
                    pixel_polygon = db.DPolygon(pixel)
                    top_region.insert(from_um * pixel_polygon)
                else:
                    for foreground_layer in foreground_layers:
                        top.shapes(foreground_layer).insert(pixel)

    if merge:
        top_region.merge()

        if smooth:
            top_region = top_region.smoothed(from_um * pixel_size * 0.99)

        for foreground_layer in foreground_layers:
            top.shapes(foreground_layer).insert(top_region)

    # Add the boundaries
    for boundary in boundaries:
        layer, datatype = boundary.split('/')
        boundary_layer = db.LayerInfo(int(layer), int(datatype))
        top.shapes(boundary_layer).insert(db.DBox.new(0, 0, new_image_binary.width * pixel_size, new_image_binary.height * pixel_size))

    # Save the layout to a file
    ly.write(output_filepath)


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        prog="img2gds", description="Convert an image to GDS format"
    )

    parser.add_argument("image_path")
    parser.add_argument("gds_path")
    parser.add_argument("--cellname", default="TOP", help="top cellname")
    parser.add_argument(
        "--pixel-size", type=float, default=0.3, help="pixel size in um"
    )
    parser.add_argument(
        "--scale", type=float, default=1.0, help="downscale the image, e.g. 0.5"
    )
    parser.add_argument(
        "--width", type=int, default=None, help="scale to image width"
    )
    parser.add_argument(
        "--height", type=int, default=None, help="scale to image height"
    )
    parser.add_argument(
        "--threshold", type=int, default=128, help="threshold to compare against"
    )
    parser.add_argument("--invert", action="store_true", help="invert the pixels")
    parser.add_argument(
        "--invert-alpha", action="store_true", help="invert the alpha pixels"
    )
    parser.add_argument("--merge", action="store_true", help="merge polygons")
    parser.add_argument(
        "--foreground",
        nargs="*",
        type=str,
        help="gds layer/datatype pair for foreground pixels e.g. 0/0",
    )
    parser.add_argument(
        "--boundary",
        nargs="*",
        type=str,
        help="gds layer/datatype pairs for boundary e.g. 0/0",
    )
    parser.add_argument("--smooth", action="store_true", help="smooth the edges")

    args = parser.parse_args()

    convert_to_gds(
        args.image_path,
        args.gds_path,
        cellname=args.cellname,
        scale=args.scale,
        width=args.width,
        height=args.height,
        threshold=args.threshold,
        invert=args.invert,
        invert_alpha=args.invert_alpha,
        merge=args.merge,
        smooth=args.smooth,
        pixel_size=args.pixel_size,
        foregrounds=args.foreground,
        boundaries=args.boundary,
    )
