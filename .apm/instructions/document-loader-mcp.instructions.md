---
description: Use the document-loader MCP (not shell utilities) to read PDF, Word, Excel, and PowerPoint files.
applyTo: "*.{pdf,docx,doc,xlsx,xls,pptx,ppt}"
---
# Use the document-loader MCP for binary documents
When working with PDF, Word, Excel, or PowerPoint files, use the
`document-loader` MCP instead of shell utilities or built-in readers.
## Capabilities (read / extraction only)
- `read_document` — extract text content from `pdf`, `docx`, `doc`, `xlsx`,
  `xls`, `pptx`, `ppt`. Requires `file_path` and `file_type`.
- `read_image` — load an image (PNG, JPG, JPEG, GIF, BMP, TIFF, WEBP) for
  analysis.
- `extract_slides_as_images` — render slides/pages of PPTX, PPT, or PDF to PNG
  images (needs LibreOffice for PPTX/PPT and poppler-utils for PDF).
## Rules
- This MCP reads and extracts; it does not write or generate these formats. For
  producing DOCX/PDF from Markdown, use a conversion tool, not this MCP.
- Prefer `read_document` over `cat`, `pdftotext`, or similar shell commands when
  extracting content from these formats.
- Pass the correct `file_type` matching the file extension.
