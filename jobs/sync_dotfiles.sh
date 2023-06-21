REPO_PATH=tfk70/dotfiles

# Sync files in .config
update_list=("alacritty" "hypr" "lvim" "waybar" "yandex-disk" "cava" "rofi" "wlogout" "swaylock" "jobs")
homedir_update_list=(".zshrc" ".p10k.zsh")

cd ~

for dir in ${update_list[@]}; do
  repo_path="./workspace/"$REPO_PATH"/"$dir
  dotfiles_path="./.config/"$dir
  rm -rf $repo_path
  echo "Removed "$repo_path
  cp -R $dotfiles_path $repo_path
  echo "Copied from "$dotfiles_path" to "$repo_path
done

# Sync files in ~

cd ~

for file in ${homedir_update_list[@]}; do
  repo_path="./workspace/"$REPO_PATH"/"$file
  homedir_path="./"$file
  rm $repo_path
  echo "Removed "$repo_path
  cp $homedir_path $repo_path
  echo "Copied from "$homedir_path" to "$repo_path
done

# Commit changes

cd "./workspace/"$REPO_PATH

git add .
git commit -m 'chore: update configs'
git push
