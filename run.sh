language="eng"
paradigm="bpe"
global_data_path="/content/data"
config_path="/content/model_template.json"

torchrun --standalone --nproc_per_node=1 /content/modded-nanogpt/run_data_driven.py $config_path $global_data_path $paradigm $language