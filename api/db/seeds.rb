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

# recipe
@recipe = Recipe.create!(
  recipe_name: '肉じゃが',
  recipe_time: 10,
  user_id: @user1.id
)

# ingredient
Ingredient.create!(
  ingredient_name: 'じゃがいも',
  quantity: '２個',
  recipe_id: @recipe.id
)

Ingredient.create!(
  ingredient_name: 'にんじん',
  quantity: '１個',
  recipe_id: @recipe.id
)

# procedure
Procedure.create!(
  procedure_content: '野菜を切る',
  recipe_id: @recipe.id
)

Procedure.create!(
  procedure_content: '野菜を茹でる',
  recipe_id: @recipe.id
)

# category
@category = Category.create!(
  category_name: '和食'
)

# recip_category_relation
RecipeCategoryRelation.create!(
  category_id: @category.id,
  recipe_id: @recipe.id
)

# comment
Comment.create!(
  comment_content: 'これはおすすめです！',
  user_id: @user1.id,
  recipe_id: @recipe.id
)