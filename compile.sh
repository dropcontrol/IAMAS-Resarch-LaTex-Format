#!/bin/bash

# Add MacTeX path
export PATH="/Library/TeX/texbin:$PATH"

echo "================================================================="
echo "LaTeX Compilation Script for Master's Thesis (English Version)"
echo "================================================================="

# Check section files
echo ""
echo "Checking section files..."
echo "-----------------------------------------------------------------"

missing=0
for i in 00_frontmatter 01_introduction 02_polyrhythm 03_multilayered 04_composition 05_embodiment 06_discussion 07_conclusion 08_appendix; do
    if [ -f "sections_en/${i}.tex" ]; then
        echo "✓ ${i}.tex"
    else
        echo "✗ Missing: ${i}.tex"
        missing=$((missing + 1))
    fi
done

echo "-----------------------------------------------------------------"
if [ $missing -gt 0 ]; then
    echo "⚠ Warning: $missing section(s) missing"
else
    echo "✓ All sections found"
fi
echo ""

# Check LaTeX environment
echo "Checking LaTeX environment..."
echo "-----------------------------------------------------------------"

if command -v uplatex &> /dev/null; then
    echo "✓ uplatex found"
    echo ""
    echo "Starting compilation..."
    echo "-----------------------------------------------------------------"

    # Clean up old files
    rm -f iamas_yamato_en.aux iamas_yamato_en.log iamas_yamato_en.toc iamas_yamato_en.dvi

    # First pass
    echo "First pass..."
    uplatex iamas_yamato_en.tex

    if [ $? -eq 0 ]; then
        echo "✓ First pass completed"

        # Second pass (for references)
        echo "Second pass (resolving references)..."
        uplatex iamas_yamato_en.tex

        if [ $? -eq 0 ]; then
            echo "✓ Second pass completed"

            # Convert to PDF
            echo "Converting to PDF..."
            dvipdfmx iamas_yamato_en.dvi

            if [ $? -eq 0 ]; then
                echo "-----------------------------------------------------------------"
                echo "✓ SUCCESS: PDF generated as iamas_yamato_en.pdf"
                echo "-----------------------------------------------------------------"

                # Display file info
                if [ -f "iamas_yamato_en.pdf" ]; then
                    echo ""
                    echo "PDF Information:"
                    ls -lh iamas_yamato_en.pdf
                fi
            else
                echo "✗ Error: Failed to convert DVI to PDF"
            fi
        else
            echo "✗ Error: Second pass failed"
        fi
    else
        echo "✗ Error: First pass failed"
        echo ""
        echo "Check iamas_yamato_en.log for details"
    fi

elif command -v platex &> /dev/null; then
    echo "⚠ uplatex not found, but platex is available"
    echo "Note: Character encoding adjustments may be needed"
    echo "Edit iamas_yamato_en.tex to use platex settings"

else
    echo "✗ No LaTeX compiler found"
    echo ""
    echo "To install LaTeX on macOS:"
    echo "  Option 1: brew install --cask basictex  (lightweight, ~100MB)"
    echo "  Option 2: brew install --cask mactex    (full, ~4GB)"
    echo ""
    echo "After installation, run:"
    echo "  sudo tlmgr update --self"
    echo "  sudo tlmgr install collection-langjapanese"
    echo ""
fi

echo "================================================================="