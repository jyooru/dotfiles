from pathlib import Path

import frontmatter


def main(source: Path = Path(".")):
    for item in source.glob("**/*"):
        if not item.is_file():
            continue

        if str(item).endswith(".md"):
            metadata = frontmatter.load(item.open())
            if "layout" not in metadata:
                metadata["layout"] = "page"
            frontmatter.dump(metadata, item.open('wb'))
            
            if item.name == "README.md":
                index_path = item.parent / "index.md"
                assert not index_path.exists()
                item.rename(index_path)


if __name__ == "__main__":
    main()
