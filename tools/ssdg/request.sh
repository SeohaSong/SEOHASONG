json='[
    "cu-usr-sool",
    {
        "usr-info": {
            "usr-id": 1,
            "token": "asdf",
            "email": "soojak.korea@gmail.com"
        },
        "sool-id": 0,
        "cert": null,
        "like": null,
        "taste": null,
        "star": null,
        "review": null,
        "pairing": null,
        "scent": null
    }
]'




bgn_time=$( date +%s%N )

curl \
    -X POST \
    -H "Content-Type: application/json" \
    -d "$json" \
    http://ec2-3-36-128-139.ap-northeast-2.compute.amazonaws.com:8000
echo

echo $(( $( date +%s%N ) - $bgn_time ))
