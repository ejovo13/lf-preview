import typer

from rich.markdown import Markdown
from rich.console import Console

app = typer.Typer(name="MarkdownPreview")


@app.command()
def main(input: str, width: int = 50):
    with open(input, "r") as file:
        lines = file.readlines()
        out = "".join(lines)
    md = Markdown(out)
    console = Console(width=width)
    console.print(md)


if __name__ == "__main__":
    app()
