import os
from dataclasses import dataclass
import json

@dataclass
class Config:
    language : str
    paradigm : str
    d_model : int
    num_heads : int
    vocab_size: int
    num_layers: int
    max_seq_len : int

@classmethod
def load(cls, config_path):
    assert os.path.exists(config_path), "Wrong path dumbass"
    with open(config_path, "r") as f:
        config = json.load(f)
    obj = cls()
    for k, v in config.items():
        if hasattr(obj, k):
            setattr(obj, k, v)
    return obj