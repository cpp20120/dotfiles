# Makefile для преобразования всех файлов .tex в PDF с использованием pandoc

# Определяем все файлы .tex в текущей директории
TEXFILES := $(wildcard *.tex)

# Создаем список файлов .pdf, соответствующих .tex
PDFFILES := $(TEXFILES:.tex=.pdf)

# Стандартное правило для всех PDF файлов
all: $(PDFFILES)

# Правило для преобразования .tex в .pdf с использованием pandoc
%.pdf: %.tex
    pandoc $< -o $@

# Правило очистки сгенерированных файлов
clean:
    rm -f *.pdf

.PHONY: all clean

