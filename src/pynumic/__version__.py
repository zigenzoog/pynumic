import os
from typing import Iterable


VERSION: Iterable[int] = (0, 1, 1)
__version__: str = ".".join(map(str, VERSION))

poetry_config: str = os.path.join("..", "..", "pyproject.toml")
