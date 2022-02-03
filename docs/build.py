import frontmatter
from os import  getcwd, walk, rename, path


source = getcwd()


def main():
    for root, dirs, files in walk(source):
        for file in files:
            if file.endswith(".md"):
                full_path = f"{root}/{file}"
                metadata = frontmatter.load(full_path)
                if "layout" not in metadata:
                    metadata["layout"] = "page"
                frontmatter.dump(metadata, full_path)
                if file == "README.md":
                    assert not path.exists(root + "index.md")
                    rename(full_path, f"{root}/index.md")

if __name__ == "__main__":
    main()