from functools import reduce
import pathlib


def walkdir(dir: pathlib.Path) -> int:
    c = reduce(lambda count, f: count + walkdir(f) if f.is_dir() else count + 1, dir.iterdir(), 0)
    print(f"{dir.name}: {c}")
    return c


if __name__ == "__main__":
    count = walkdir(pathlib.Path("./Arxius"))
    print(f"En total hi ha {count} arxius")