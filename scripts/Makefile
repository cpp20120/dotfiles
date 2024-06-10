# Makefile для преобразования всех файлов .tex в PDF и DOCX с использованием pandoc

# Определяем все файлы .tex в текущей директории
TEXFILES := $(wildcard *.tex)

# Создаем список файлов .pdf и .docx, соответствующих .tex
PDFFILES := $(TEXFILES:.tex=.pdf)
DOCXFILES := $(TEXFILES:.tex=.docx)

# Стандартное правило для всех PDF и DOCX файлов
all: pdf docx

# Правило для преобразования .tex в .pdf с использованием pandoc
pdf: $(PDFFILES)

%.pdf: %.tex
    pandoc $< -o $@

# Правило для преобразования .tex в .docx с использованием pandoc
docx: $(DOCXFILES)

%.docx: %.tex
    pandoc $< -o $@

# Правило очистки сгенерированных файлов
clean:
    rm -f *.pdf *.docx

.PHONY: all pdf docx clean
