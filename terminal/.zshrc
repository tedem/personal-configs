# clean_zip - Removes __MACOSX directories and .DS_Store files from a zip archive
#
# Usage:
#   clean_zip <zipfile>
#
# Arguments:
#   zipfile - The path to the zip file to be cleaned.
#
# Description:
#   This function takes a zip file as an argument and removes any __MACOSX directories
#   and .DS_Store files contained within it. If no zip file is specified, or if the
#   specified file does not exist, an error message is displayed.
#
#   The function performs the following steps:
#     1. Checks if a zip file is specified. If not, it prints an error message and exits.
#     2. Checks if the specified zip file exists. If not, it prints an error message and exits.
#     3. Checks if the zip file contains any __MACOSX directories or .DS_Store files.
#     4. If __MACOSX directories are found, they are removed from the zip file.
#     5. If .DS_Store files are found, they are removed from the zip file.
#     6. If no __MACOSX directories or .DS_Store files are found, a message is printed indicating that there are no files to remove.
#
# Example:
#   clean_zip tedem.zip
clean_zip() {
    if [ -z "$1" ]; then
        echo -e "\033[31mLütfen bir zip dosyası belirtin.\033[0m"
        return 1
    fi

    local zipfile="$1"

    if [ ! -f "$zipfile" ]; then
        echo -e "\033[31mDosya bulunamadı: $zipfile\033[0m"
        return 1
    fi

    echo -e "\033[34mTemizleniyor: $zipfile\033[0m"

    macosx_exists=$(unzip -l "$zipfile" | grep -c "__MACOSX")
    dsstore_exists=$(unzip -l "$zipfile" | grep -c ".DS_Store")

    if [ "$macosx_exists" -gt 0 ]; then
        zip -d "$zipfile" "__MACOSX/*"
        echo -e "\033[32m__MACOSX klasörleri silindi.\033[0m"
    fi

    if [ "$dsstore_exists" -gt 0 ]; then
        zip -d "$zipfile" "*/.DS_Store"
        echo -e "\033[32m.DS_Store dosyaları silindi.\033[0m"
    fi

    if [ "$macosx_exists" -eq 0 ] && [ "$dsstore_exists" -eq 0 ]; then
        echo -e "\033[33mSilinecek hiçbir dosya bulunamadı.\033[0m"
    fi
}
