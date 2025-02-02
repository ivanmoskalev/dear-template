#!/usr/bin/env zsh

set -e

echo "Enter the name of the library to be created: "
read libname 

if [[ $libname =~ ^Xn[A-Z][a-z]*$ ]]; then
    echo "Library name is valid"
else
    echo "Library name is invalid, must start with Xn followed by a capital letter and then lowercase letters"
    exit 1
fi

echo "Moving files and renaming them..."

mkdir -p Sources/$libname
mkdir -p Tests/${libname}Unit
mkdir -p Tests/${libname}Performance

mv Sources/XnTemplate/XnTemplate.swift Sources/$libname/$libname.swift
mv Tests/XnTemplateUnit/XnTemplateUnit.swift Tests/${libname}Unit/${libname}Unit.swift
mv Tests/XnTemplatePerformance/XnTemplatePerformance.swift Tests/${libname}Performance/${libname}Performance.swift

rm -r Sources/XnTemplate
rm -r Tests/XnTemplateUnit
rm -r Tests/XnTemplatePerformance

echo "Renaming file contents..."

sed -i '' "s/XnTemplate/$libname/g" Package.swift
sed -i '' "s/XnTemplate/$libname/g" Sources/$libname/$libname.swift
sed -i '' "s/XnTemplate/$libname/g" Tests/${libname}Unit/${libname}Unit.swift
sed -i '' "s/XnTemplate/$libname/g" Tests/${libname}Performance/${libname}Performance.swift
sed -i '' "s/XnTemplate/$libname/g" README.md
sed -i '' "s/XnTemplate/$libname/g" .github/workflows/tests.yml

echo "Library setup complete. Self-destructing setup.sh..."

rm setup.sh
