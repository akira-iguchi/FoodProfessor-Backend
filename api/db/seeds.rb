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

# follow
Follow.create!(
  follower_id: @user1.id,
  followed_id: @user2.id,
)

# folder
@folder = Folder.create!(
  folder_name: '夕食',
  user_id: @user1.id
)

# recipe
@recipe = Recipe.create!(
  recipe_name: '肉じゃが',
  recipe_time: 10,
  folder_id: @folder.id,
  user_id: @user1.id
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

# purpose
@purpose = Purpose.create!(
  purpose_name: 'すぐ作れる',
  purpose_content: '忙しいように',
  purpose_for_people: 1,
  recipe_id: @recipe.id
)

# ingredient
Ingredient.create!(
  ingredient_name: 'じゃがいも',
  quantity: 2,
  purpose_id: @purpose.id
)

Ingredient.create!(
  ingredient_name: 'にんじん',
  quantity: 1,
  purpose_id: @purpose.id
)

# procedure
Procedure.create!(
  procedure_content: '野菜を切る',
  order: 1,
  purpose_id: @purpose.id
)

Procedure.create!(
  procedure_content: '野菜を茹でる',
  order: 2,
  purpose_id: @purpose.id
)

# comment
Comment.create!(
  comment_content: 'これはおすすめです！',
  user_id: @user1.id,
  recipe_id: @recipe.id
)