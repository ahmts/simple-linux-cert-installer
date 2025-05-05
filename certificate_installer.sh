#!/bin/bash

echo "Please drag and drop the certificate file into the terminal and press Enter:"
read -r CERT_PATH

# Remove surrounding quotes if they exist
CERT_PATH=$(echo "$CERT_PATH" | sed "s/^'//;s/'$//")

# Check if file exists
if [[ ! -f "$CERT_PATH" ]]; then
    echo "Error: File not found!"
    exit 1
fi

# Extract extension and filename
EXT="${CERT_PATH##*.}"
BASENAME=$(basename "$CERT_PATH")
DEST="/etc/ca-certificates/trust-source/anchors/$BASENAME"

# Check file extension
case "$EXT" in
    crt|cer|pem)
        # Warn if the certificate already exists
        if [[ -f "$DEST" ]]; then
            echo "⚠️  Warning: A certificate with the same name already exists:"
            echo "    $DEST"
            read -p "Do you want to overwrite it? (y/n): " ANSWER
            if [[ "$ANSWER" != "y" && "$ANSWER" != "Y" ]]; then
                echo "Operation cancelled."
                exit 0
            fi
        fi

        echo "Copying certificate..."
        sudo cp "$CERT_PATH" "$DEST" || {
            echo "Error: Failed to copy the certificate!"
            exit 1
        }

        echo "Updating system trust store..."
        sudo trust extract-compat || {
            echo "Error: Failed to update trust store!"
            exit 1
        }

        echo "✅ Certificate successfully installed."
        ;;
    *)
        echo "❌ Invalid file extension. Only .crt, .cer, and .pem are supported."
        exit 1
        ;;
esac
