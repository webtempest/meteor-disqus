# Meteor Disqus

Load disqus dynamically using an `_id` or fallback to current URL.

## Install

`meteor add webtempest:disqus`

## Usage

First initialize disqus and pass in your shortname (you will need to create a new 'Site' in Disqus to get this). You can do this anywhere - just make sure it's only on the client. You also don't have to attach it to the window.

```js
window.disqus = new Disqus('your_shortname');
```

### Comments

Make sure your template has the `<div>` that holds your comment thread (yes the `id` MUST be 'disqus_thread'):

```html
<div id="disqus_thread"></div>
```

In your javascript, load the comments (usually in your `onRendered` callback):

```js
Template.blogPost.onRendered(function(){
  disqus.loadComments();
});
```

You can pass in the following (optional) options to `loadComments`. 

`identifier`
A unique id for your comment thread - defaults to current URL. I recommend passing in the `_id` of whatever database object your showing.

`title`
A title for the comment thread. Defaults to page `<title>`.

`url`
URL of current page. Defaults to `window.location.href`. I wouldn't bother with this.

`category_id`
The category used for the current page. I don't really know what this is for so don't worry about it.

[Official docs here](https://help.disqus.com/customer/portal/articles/472098-javascript-configuration-variables).

Most common usecase:

```js
Template.blogPost.onRendered(function(){
  var post = Posts.findOne(idFromRouter);
  disqus.loadComments({
    identifier: post._id,
    title: post.title
  });
});
```

### Comment counts

Maybe on your home page you want to display the number of comments for a particular thread.

There are two ways of specifying where you want your `count` to be in your html.

#### Option 1 - `<a>` tags only. 

Find the `<a>` tag you want to display your comments and make sure the `href` attribute follows this pattern:

`url_of_comment_thread#disqus_thread`

So if you had a blog post and it is sitting on the URL `http://yourblog.com/posts/my-post`, then your `<a>` should be:

`<a href="http://yourblog.com/posts/my-post#disqus_thread"></a>`

Then in your javascript, run this AFTER your template has rendered:

```js
disqus.loadCounts();
```

This simply downloads the disqus counts script, which will look over your code for these kinds of URLs and replace the contents with "3 comments" or whatever your comment count is. You can change what is actually written in your Disqus admin - eg. you can make it say "3 amazing comments" or something.

#### Option 2 - non `<a>` tags

If you want to use a `<span>` or something to show your comment count, the element needs two things:

1. a `class` of "disqus-comment-count"
2. a `data` attribute - can either be `data-disqus-url` or `data-disqus-identifier` (depending on whether you pass in identifiers or not in your `loadComments()` calls)

Example: if you rely on URLs as identifiers:
```html
<span class="disqus-comment-count" data-disqus-url="http://yourblog.com/posts/my-post"></span>`
```

Example: if you pass in real identifiers (like an `_id` of a blog post):
```html
<span class="disqus-comment-count" data-disqus-identifier="article_1_identifier"></span>`
```
