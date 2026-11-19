#!/usr/bin/env bash
# Builds the web CV (no phone number) from the master CV source.
set -euo pipefail
SRC="$HOME/kariyer/cv/cv_general.tex"
OUT="$(cd "$(dirname "$0")/.." && pwd)/assets"
TMP="$(mktemp -d)"
# Drop any "+<country code> <digits> \textbar{}" segment from the header.
sed -E 's/\+[0-9][0-9 ]{6,} *\\textbar\{\} *//' "$SRC" > "$TMP/cv_web.tex"
grep -qE '\+[0-9]{2}[0-9 ]{6,}' "$TMP/cv_web.tex" && { echo "phone still present"; exit 1; }
(cd "$TMP" && pdflatex -interaction=nonstopmode cv_web.tex >/dev/null && pdflatex -interaction=nonstopmode cv_web.tex >/dev/null)
cp "$TMP/cv_web.pdf" "$OUT/Ali_Taylan_Dursun_CV.pdf"
rm -rf "$TMP"
echo "ok: $OUT/Ali_Taylan_Dursun_CV.pdf"
