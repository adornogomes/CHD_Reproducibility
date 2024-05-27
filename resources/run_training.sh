#!/bin/bash
python3 -m retrain --bottleneck_dir=/output/bottlenecks --how_many_training_steps=4000 --model_dir=/output/models/ --summaries_dir=/output/training_summaries/"${ARCHITECTURE}" --output_graph=/output/retrained_graph.pb --output_labels=/output/retrained_labels.txt --architecture="${ARCHITECTURE}" --image_dir=rx
