Note:

Rails 4.x requires that scopes use a callable object. You need to take care of
this mostly on ordering those `has_many` relationships. For example, instead of
`has_many :videos, order: :name` you should do `has_many :videos, ->{ order(:name) }`

When you want to update gems, do it deliberately, one at a time. If you would
update a gem, run the entire test suite to make sure everything still works,
then update the next one, etc.

# HAML

```html
<strong><%= item.title %></strong>
```

```
%strong= item.title
```

In Haml, we write a tag by using the percent sign and then the name of the tag.
This works for `%strong`, `%div`, `%body`, `%html` any tag you want. Then, after
the name of the tag is `=`, which tells Haml to evaluate Ruby code to the right
and then print out the return value as the contents of the tag.

```html
<strong class="code" id="message">Hello, World!</strong>
```

```
%strong{:class => "code", :id => "message"} Hello, World!
```

The attributes are just standard Ruby hash. We did not use `=` so "Hello, World!
" is interpreted as a normal string, not Ruby code.

```
%strong.code#message Hello, World!
```

`div` tags are so common, you can leave off the tag definition and have it
default to `%div`.

```
.content Hello, World!
```

```html
<div class="content">
  Hello, World!
</div>
```

```html
<div class="item" id="item<%= item.id %>">
  <%= item.body %>
</div>
```

```
.item{:id => "item#{item.id}"}= item.body
```

```html
<div id="content">
  <div class="left column">
    <h2>Welcome to our site!</h2>
    <p><%= print_information %></p>
  </div>
  <div class="right column">
    <%= render :partial => "sidebar" %>
  </div>
</div>
```

```
#content
  .left.column
    %h2 Welcome to our site!
    %p= print_information
  .right.column
    = render :partial => "sidebar"
```

Haml functions is a replacement for inline page templating systems such as
PHP, ERB, and ASP.

```
#content
  .title
    %h1= @title
    = link_to 'Home', home_url
```

```html
<div id="content">
  <div class="title">
    <h1></h1>
    <a href="/">Home</a>
  </div>
</div>
```

All strings printed to a Haml template are escaped by default.

The `:class` and `:id` attributes can also be specified as a Ruby array whose
elements will be joined together. A `:class` array is joined with " " and an
`:id` array is joined with `_`. For example:

```
%div{:id => [@item.type, @item.number], :class => [@item.type, @item.urgency]}
```

The array will be first flattened and any elements that do not test as true will
be removed.

HTML style attributes.

```
%html(xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en")
```

Ruby variables can be used by omitting the quotes.

```
%a(title=@title href=href) Stuff
```

This is the same as

```
%a{:title => @title, :href => href} Stuff
```

Custom data attributes can be used in Haml by using the key `:data` with a Hash
in an attribute hash.

# Object Reference: []

Square brackets follow a tag definition and contain a Ruby object that is used
to set the class and id of that tag. The class is set to the object's class
(transformed to use underlines rather than camel case) and the id is set to the
object's class, followed by the value of its `#to_key` or `#id` method (in that
order). This is most useful for elements that represent instances of Active
Model models. Additionally, the second argument (if present) will be used as
a prefix for both the id and class attributes. For example:

```
def show
  @user = CrazyUser.find(15)
end

%div[@user, :greeting]
  %bar[290]/
  Hello!
```

is compiled to:

```html
<div class="greeting_crazy_user" id="greeting_crazy_user_15">
  <bar class="fixnum" id="fixnum_581" />
  Hello!
</div>
```

# Prototype Process for Web Apps

1. Idea
2. Wireframes
  - communication
  - workflow
  - scoping
3. Design
  - layouts
  - colors
  - look and feel
4. Slicing
5. Development

# What is GitHub Flow?

* Anything in the master branch is deployable
* To work on something new, create a descriptively named branch off of master
(ie: new-oauth2-scopes)
* Commit to that branch locally and regularly push your work to the same named
branch on the server.
* When you need feedback or help, or you think the branch is ready for merging,
open a pull request.
* After someone else has reviewed and signed off on the feature, you can merge
it into master
* Once it is merged and pushed to master, you can and should deploy immediately

# How to design test cases?

* You should derive what you expect a piece of software to do (the happy path
cases) from the product design and specification. In other words, those are not
programming decisions, but product design decisions. If there's no clarity on
this, it should be brought up to a high level (product owner / client / project
manager, etc) to be discussed in detail, without a single line of code written.
If you are working on your own product, go back to the white board and do more
detailed feature planning.
* Most of your edge cases are going to be around supporting user's interaction
and data inputs. Therefore it's helpful to think from the user's perspective
and consider all the possible ways users can interact with your app, and
especially, how different types of user inputs could potentially break the app
and how you handle them gracefully.
* Write your tests first. This way it forces you to think independent of your
actual implementation. Otherwise after you implement it, you are likely to be
boxed into one way of thinking and won't be able to consider more possibilities.
* Don't shoot for perfection. No matter how hard you try, you won't possibly
imagine all the ways users will use your app. Set up run time monitoring, and
when users "break" your app, you can convert that edge case into a test case and
build up your test coverage over time this way.

# Prefer `let` to an instance variable for a couple of reasons:

* Instance variables spring into existence when referenced. This means that if
you fat finger the spelling of instance variable, a new one will be created and
initialized to `nil`, which can lead to subtle bugs and false positives. Since
`let` creates a method, you'll get a `NameError` when you misspell it, which
which is preferable. It makes it easier to refactor specs, too.
* A `before(:each)` hook will run before each example, even if the example
does not use any of the instance variables defined in the hook. This usually
isn't a big deal, but if the setup of the instance variable takes a long time,
then you're wasting cycles. For the method defined by `let`, the initialization
code only runs if the example calls it.
* You can refactor from a local variable in an example directly into a let
without

# To understand how `let` allows lazy evaluation:

```rb
# this:
let(:foo) { Foo.new }

# is very nearly equivalent to this:
def foo
  @foo ||= Foo.new
end
```

with a `let`, you are essentially defining a method that can be executed. The
code inside of the method won't be executed when the method is defined, but when
it is called. Also, the memoization pattern ensures that whatever inside of a
`let` block is only computed / executed once - when it's called again it just
simply return he value stored in the `@foo` instance var, in the example above.

# Transactions

A transaction acts on a single database connection. If you have multiple class
-specific databases, the transaction will not protect interaction among them.

We use transactions as a protective wrapper around SQL statements to ensure
changes to the database only occur when all actions succeed together.
Transactions help the developer enforce data integrity within the application.

```rb
ActiveRecord::Base.transaction do
  david.withdraw(100)
  mary.deposit(100)
end
```

In Rails transactions are available as class and instance methods for all
ActiveRecord models. It is perfectly fine to mix model types inside a single
transaction block. This is because the transaction is bound to the database
connection not the model instance. Rails already wraps the #save and #destroy
methods in a single transaction, therefore a transaction is never needed when
updating a single record.

Transactions reset the state of records through a process called rollback. In
Rails, rollbacks are only triggered by an exception.

```rb
ActiveRecord::Base.transaction do
  david.update_attribute(:amount, david.amount - 100)
  mary.update_attribute(:amount, 100)
end
```

In Rails, #update_attribute is designed not to throw an exception when an update
fails. It returns false, and for this reason you should ensure that the methods
used throw an exception upon failure. A better way to write the previous example
would be:

```rb
ActiveRecord::Base.transaction do
  david.update_attributes!(:amount => -100)
  mary.update_attributes!(:amount => 100)
end
```

The bang modifier (!) is a Rails convention for a method which will throw an
exception upon failure.

By design magic finders will return nil when no record is returned. This is in
contrast to the normal #find_ method which throws an
ActiveRecord::RecordNotFound exception.

```rb
ActiveRecord::Base.transaction do
  david = User.find_by_name("david")
  if david.id != john.id
    john.update_attributes!(:amoount => -100)
    mary.update_attributes!(:amoount => 100)
  end
end
```

```rb
ActiveRecord::Base.transaction do
  david = User.find_by_name("david")
  raise ActiveRecord::RecordNotFound if david.nil?
  if david.id != john.id
    john.update_attributes!(:amoount => -100)
    mary.update_attributes!(:amoount => 100)
  end
end
```

When the exception occurs it will be raised outside of the transaction block
after the rollback is completed. Your application code must be ready to catch
this exception as it bubbles up through the application stack.

It is also possible to invalidate a transaction without raising an exception
that will propagate upwards by using ActiveRecord::Rollback. This special
exception allows you to invalidate a transaction and reset the database records
without needing to rescue elsewhere in your code.

ActiveRecord::Rollback does not propagate outside of the containing transaction
block and so the parent transaction does not receive the exception nested inside
the child. Since the contents of the child transaction are lumped into the
parent transaction both records are created!

To ensure a rollback is received by the parent transaction you must add the
`:requires_new => true` option to the child transaction.

A transaction only acts upon the current database connection. If your
application writes to multiple databases at once you will need to wrap the
method inside a nested transaction.

```rb
Client.transaction do
  Product.transaction do
    product.buy(@quantity)
    client.update_attributes!(:sales_count => @sales_count + 1)
  end
end
```

`#save` and `#destroy` are wrapped inside a transaction. This means that
callbacks like `#after_save` is still part of the active transaction which might
still be rolled back! Therefore if you want code to execute that is
guaranteed to execute outside of the transaction use one of the transaction
specific callbacks like `#after_commit` or `#after_rollback`

# Acceptance Tests at a Single Level of Abstraction

Acceptance test: a logical progression through a task within an application.

At the heart of understanding the story being told is a consistent, single level
of abstraction, that is, each piece of behavior is roughly similar in terms
of functionality extracted and its overall purpose.

By extracting behavior to well-named methods, the developer can better tell the
story of each scenario by describing behaviors consistently and at a high enough
level that others will understand the goal and outcomes of the rest.

# Four-Phase Test

```rb
test do
  setup
  exercise
  verify
  teardown
end
```
