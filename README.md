# xclip for mac

This project provides an executable with a xclip-compatible interface, which can be useful,
if you're too lazy to refactor your linux dev shell utilities.

If you pipe to it and write something in it, or pass `-o` in the arguments at any position,
it will act as `pbcopy`.
If you write nothing to it, it will become `pbpaste`.
