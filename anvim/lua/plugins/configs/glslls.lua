filetypes {
  "glsl", "frag", "vert",
}
return {
  offsetEncoding = { "utf-8", "utf-16" },
  textDocument = {
    completion = {
      editsNearCursor = true
    }
  },
  "glsls",
  "--stdin",
}
