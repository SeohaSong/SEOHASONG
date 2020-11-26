json='[
    "get-acct",
    {}
]'

curl \
    -X POST \
    -H "Content-Type: application/json" \
    -d "$json" \
    localhost:8000
