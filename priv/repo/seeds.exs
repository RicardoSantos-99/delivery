# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Delivery.Repo.insert!(%Delivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Delivery.{Repo, User, Order, Item}

%{password_hash: hash} = Pbkdf2.add_hash("123123")

user = %User{
  cpf: "12312312312",
  email: "johndoe@com.example",
  name: "johndoe",
  address: "Rua dos bobo",
  age: 22,
  cep: "07944040",
  password_hash: hash
}

item1 = %Item{
  category: :drink,
  description: "suco de batata",
  price: Decimal.new("12.00"),
  photo: "/priv/photos/fruta.png"
}

item2 = %Item{
  category: :drink,
  description: "suco de fruta",
  price: Decimal.new("12.00"),
  photo: "/priv/photos/fruta.png"
}

item3 = %Item{
  category: :drink,
  description: "suco de limoes",
  price: Decimal.new("12.00"),
  photo: "/priv/photos/fruta.png"
}

IO.puts("Creating user...")
%User{id: user_id} = Repo.insert!(user)

IO.puts("Creating items...")

Repo.insert!(item1)
Repo.insert!(item2)
Repo.insert!(item2)

order = %Order{
  user_id: user_id,
  items: [item1, item2, item3],
  address: "Rua dos bobo",
  comments: "lero lero",
  payment_method: :credit_card
}

IO.puts("Creating orders...")
Repo.insert!(order)
