CONFIG_PATH="/mnt/data/configs/Updated/configs/tokenizer_configs" # path to config
DATA_PATH="/mnt/data/data" # global path to data (should look like ...data/ without the corpus)
WEIGHTS_PATH="/mnt/data/weights" # global path to weight storage
OUT_PATH=""

languages=("span")
paradigms=("syl")
cross_val_counter=(0,1,2,3,4,5,6,7,8,9)

# args
# config data_path weights_path out_path pretraining cross_val_counter

# torchrun --standalone --nproc_per_node=1 modded_train_gpt2.py $CONFIG $DATA_PATH $WEIGHTS_PATH $PRETRAINING


# pretraining only
for lang in "${languages[@]}"; do
  for p in "${paradigms[@]}"; do
    config="$CONFIG_PATH/${lang}_${p}_config.json"
    torchrun --standalone --nproc_per_node=2 modded_train_gpt2.py "$config" "$DATA_PATH" "$WEIGHTS_PATH" "$OUT_PATH" --pretraining True
  done
done

#for lang in "${languages[@]}"; do
#  for p in "${paradigms[@]}"; do
#    for c in ${cross_val_counter[@]}; do
#      config="${lang}_${p}_config.json"
#      torchrun --standalone --nproc_per_node=1 modded_train_gpt2.py "$config" "$data_path" "$out_path" $c
#      done
#  done
#done