# user
@user1 = User.create!(
  first_name: 'yamada',
  last_name: 'taro',
  email: 'test@example.com',
  password: 'test123',
  password_confirmation: 'test123'
)

@user2 = User.create!(
  first_name: 'suzuki',
  last_name: 'jiro',
  email: 'test@test.com',
  password: 'test456',
  password_confirmation: 'test456'
)

# recipe(肉じゃが)
@recipe1 = Recipe.create!(
  recipe_name: '肉じゃが',
  recipe_time: 40,
  for_how_many_people: 2,
  user_id: @user1.id
)

# ingredient(肉じゃが)
Ingredient.create!(
  ingredient_name: '豚肉',
  quantity: '200g',
  recipe_id: @recipe1.id
)

Ingredient.create!(
  ingredient_name: 'じゃがいも',
  quantity: '3個',
  recipe_id: @recipe1.id
)

Ingredient.create!(
  ingredient_name: 'にんじん',
  quantity: '1本',
  recipe_id: @recipe1.id
)

Ingredient.create!(
  ingredient_name: '玉ねぎ',
  quantity: '1個',
  recipe_id: @recipe1.id
)

Ingredient.create!(
  ingredient_name: '水',
  quantity: '200ml',
  recipe_id: @recipe1.id
)

Ingredient.create!(
  ingredient_name: 'しょうゆ',
  quantity: '大さじ2',
  recipe_id: @recipe1.id
)

Ingredient.create!(
  ingredient_name: '酒',
  quantity: '大さじ2',
  recipe_id: @recipe1.id
)

Ingredient.create!(
  ingredient_name: 'みりん',
  quantity: '大さじ2',
  recipe_id: @recipe1.id
)

Ingredient.create!(
  ingredient_name: '砂糖',
  quantity: '大さじ2',
  recipe_id: @recipe1.id
)

Ingredient.create!(
  ingredient_name: '顆粒和風だし',
  quantity: '大さじ1/2',
  recipe_id: @recipe1.id
)

# procedure(肉じゃが)
Procedure.create!(
  procedure_content: '豚肉やじゃがいも、にんじん、玉ねぎを適当な大きさに切る。',
  recipe_id: @recipe1.id
)

Procedure.create!(
  procedure_content: '豚肉を炒める（必要なら油を敷く）。',
  recipe_id: @recipe1.id
)

Procedure.create!(
  procedure_content: '野菜も加えて軽く炒めたら砂糖とお水を注ぎ入れる。',
  recipe_id: @recipe1.id
)

Procedure.create!(
  procedure_content: '他の調味料も加えて落としぶたをし、弱火で20~30分煮込む。',
  recipe_id: @recipe1.id
)

Procedure.create!(
  procedure_content: 'じゃがいもとにんじんに箸がスッと通れば完成。',
  recipe_id: @recipe1.id
)

# recipe(だし巻き卵)
@recipe2 = Recipe.create!(
  recipe_name: 'だし巻き卵',
  recipe_time: 40,
  for_how_many_people: 4,
  user_id: @user1.id
)

# ingredient(だし巻き卵)
Ingredient.create!(
  ingredient_name: '卵',
  quantity: '4個',
  recipe_id: @recipe2.id
)

Ingredient.create!(
  ingredient_name: '水',
  quantity: '大さじ6',
  recipe_id: @recipe2.id
)

Ingredient.create!(
  ingredient_name: 'ほんだし',
  quantity: '小さじ1/2',
  recipe_id: @recipe2.id
)

Ingredient.create!(
  ingredient_name: 'みりん',
  quantity: '小さじ2',
  recipe_id: @recipe2.id
)

Ingredient.create!(
  ingredient_name: 'うす口しょうゆ',
  quantity: '小さじ1',
  recipe_id: @recipe2.id
)

Ingredient.create!(
  ingredient_name: '油',
  quantity: '適量',
  recipe_id: @recipe2.id
)

# procedure(だし巻き卵)
Procedure.create!(
  procedure_content: 'ボウルに卵を割り、切るように溶く。混ぜ合わせた調味料を加えてさらに混ぜる。',
  recipe_id: @recipe2.id
)

Procedure.create!(
  procedure_content: '卵焼き器を強めの中火で熱し、油を敷いてなじませる。卵液を玉じゃくし七分目ほど入れて広げ、半熟になったら向こう側から手前に向かって巻き、巻いた卵を向こう側に送る。',
  recipe_id: @recipe2.id
)

Procedure.create!(
  procedure_content: '卵焼き器に油をなじませ、再び卵液を流し入れる。巻いた卵を持ち上げて下に卵液を流し、卵のフチが固まってきたら手前に巻き込む。同様にくり返し焼く。',
  recipe_id: @recipe2.id
)

Procedure.create!(
  procedure_content: '焼き上がったらまな板に取り出し、粗熱が取れたら食べやすい大きさに切り、器に盛る',
  recipe_id: @recipe2.id
)

# category
@category1 = Category.create!(
  category_name: '和食'
)

@category2 = Category.create!(
  category_name: '洋食'
)

@category3 = Category.create!(
  category_name: '朝食'
)

@category4 = Category.create!(
  category_name: '昼食'
)

@category5 = Category.create!(
  category_name: '夕食'
)

# recip_category_relation
RecipeCategoryRelation.create!(
  category_id: @category1.id,
  recipe_id: @recipe1.id
)

# comment
Comment.create!(
  comment_content: 'これはおすすめです！',
  user_id: @user1.id,
  recipe_id: @recipe1.id
)

# favorite
Favorite.create!(
  user_id: @user1.id,
  recipe_id: @recipe1.id
)