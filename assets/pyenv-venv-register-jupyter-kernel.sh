#!/bin/sh

# this script also available as gist:
# https://gist.github.com/lucasrla/c16f19290938ac02bab19f64298e2262

if [ -z "$VIRTUAL_ENV" ]; then
    echo "ABORTED: couldn't find an active virtualenv. Check with 'pyenv virtualenvs' if there is one activated"
    exit 1
fi

venv=$(basename "$VIRTUAL_ENV")
python=$(pyenv which python) #"$VIRTUALENV/bin/python"
jupyter_data_dir=$(jupyter --data-dir)
kernel_dir="${jupyter_data_dir}/kernels/${venv}"

if [ -e "$kernel_dir"/kernel.json ]; then
    echo "ABORTED: jupyter kernel $kernel_dir/kernel.json already exists"
    exit 1
fi

echo "Creating jupyter kernel named $venv ($python)"

pip install ipykernel
mkdir -p "$kernel_dir"

cat > "$kernel_dir"/kernel.json <<EOF
{
    "argv": [ "$python", "-m", "ipykernel", "-f", "{connection_file}" ],
    "display_name": "$venv", 
    "language": "python"
}
EOF

#cat "$kernel_dir"/kernel.json 

echo "SUCCESS: jupyter kernel created at $kernel_dir/kernel.json"