import argparse
import subprocess
import pathlib import Path
import sys

def main() -> None:
    parser = argparse.ArgumentParser(
        prog="pdf",
        description="Markdown to PDF converter",
    )

    parser.add_argument("input", help="<input.md>")
    parser.add_argument("input", nargs="?", help="<output.pdf>")
    arser.add_argument(
        "-H", "--header",
        choices=["dark", "light"],
        default="dark",
        help="<color scheme [dark | light]>"
    )

    args = parser.parse_args()

    in_file = Path(args.input)

    if args.output:
        out_file = Path(args.output)
    else:
        out_file = in_file.with_suffix(".pdf")


    scheme_dir = Path(__file__).resolve().parent.parent / "schemes"
    if args.header == "dark":
        header_file = scheme_dir / "gruvbox-dark.tex"
    else:
        header_file = scheme_dir / "gruvbox-light.tex"


    cmd = [
        "pandoc",
        str(in_file),
        "-o", str(out_file),
        "--pdf-engine=xelatex",
        "--pdf-engine-opt=-shell-escape",
        "-H", str(header_file)
    ]

    print(f"[pdf] Wrote {out_file}")

if __name__ == "__main__":
    sys.exit(main())
