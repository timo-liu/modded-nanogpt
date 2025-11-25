CONFIG="" # path to config
DATA_PATH="" # global path to data (should look like ...data/ without the corpus)
WEIGHTS_PATH="" # global path to weight storage
OUT_PATH=""

languages=("eng" "span")
paradigms=("syl" "bpe" "morf")
cross_val_counter=(0,1,2,3,4,5,6,7,8,9)

# args
# config data_path weights_path out_path pretraining cross_val_counter

torchrun --standalone --nproc_per_node=1 modded_train_gpt2.py $CONFIG $DATA_PATH $WEIGHTS_PATH $PRETRAINING


# pretraining only
for lang in "${languages[@]}"; do
  for p in "${paradigms[@]}"; do
    config="${lang}_${p}_config.json"
    torchrun --standalone --nproc_per_node=1 modded_train_gpt2.py "$config" "$DATA_PATH" "$WEIGHTS_PATH" "$OUT_PATH" True
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