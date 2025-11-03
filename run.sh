language = "eng"
paradigm = "syl"
global_data_path = "/mnt/data/shared/timo/Updated/data"

torchrun --standalone --nproc_per_node=8 train_gpt.py $global_data_path $paradigm $language