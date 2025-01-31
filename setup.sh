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

mv Sources/XnTemplate/XnTemplate.swift Sources/$libname/$libname.swift
mv Tests/XnTemplateTests/XnTemplateTests.swift Tests/${libname}Tests/${libname}Tests.swift

echo "Renaming file contents..."

sed -i '' "s/XnTemplate/$libname/g" Package.swift
sed -i '' "s/XnTemplate/$libname/g" Tests/${libname}Tests/${libname}Tests.swift
sed -i '' "s/XnTemplate/$libname/g" README.md

echo "Library setup complete. Self-destructing setup.sh..."

rm setup.sh
