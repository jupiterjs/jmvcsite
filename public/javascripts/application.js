$.Controller('PostAdministration', {}, {
	'.expand click' : function(){
		$.getJSON('/posts/' + this.element.data('post-id') + '.json', this.callback('expandPost'));
	},
	'.approve click' : function(){
		var approval = this.element.hasClass('post-not-approved');
		$.post('/posts/' + this.element.data('post-id') + '.json', withCsrf({_method: 'PUT', post: {is_approved: approval}}), this.callback('approvePost'));
	},
	'.delete click' : function(){
		if(confirm('Are you sure?')){
			$.post('/posts/' + this.element.data('post-id'), withCsrf({_method: 'DELETE'}), this.callback('removePost'))
		}
	},
	approvePost : function(data){
		if(data.post.is_approved){
			this.element.removeClass('post-not-approved');
			this.element.find('span').text('This post is already approved.');
			this.element.find('.approve').text('Disapprove');
		} else {
			this.element.addClass('post-not-approved');
			this.element.find('span').text('This post is not approved by administration yet.');
			this.element.find('.approve').text('Approve');
		}
		
	},
	expandPost : function(json){
		var body = json.post.processed_body;
		if(body != ""){
			if(this.element.find('.post-body').length == 0)
				this.element.find('.post-title').after('<div class="post-body">' + body + '</div>');
			else {
				this.element.find('.post-body').html(body);
			}
		}
	},
	removePost : function(){
		var self = this;
		this.element.slideUp(function(){
			self.element.remove()
		})
		
	}
})

$.Controller('UserAdministration', {}, {
	'.make-admin click' : function(){
		var admin = !this.element.hasClass('is-admin');
		$.post('/users/' + this.element.data('user-id') + '.json', withCsrf({_method: 'PUT', user: {is_admin: admin}}), this.callback('makeAdmin'));
	},
	makeAdmin : function(data){
		if(data.user.is_admin){
			this.element.addClass('is-admin');
			this.element.find('span').text('This user is an admin.');
			this.element.find('.make-admin').text('Disable admin status');
		} else {
			this.element.removeClass('is-admin');
			this.element.find('span').text('');
			this.element.find('.make-admin').text('Enable admin status');
		}
		
	}
})



jQuery.Controller.extend('Feed',
/* @Static */
{
},
/* @Prototype */
{
	date_template: '{day}, {date} {month} {year}',
	days : ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],
	months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
	linkify : function(text){
		var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
		return text.replace(exp,"<a href='$1'>$1</a>");
	},
	formatDate : function(date_string){
		var date = new Date(date_string);
		return $.String.sub(this.date_template, {
			day: this.days[date.getDay()],
			date: date.getDate(),
			month: this.months[date.getMonth()],
			year: date.getFullYear()
		});
	}
});


Feed.extend('TwitterFeed',
/* @Static */
{
},
/* @Prototype */
{
	template: "<li>{tweet}<br /><span>{user} on {date}</span></li>",
	init : function(){
		var twitterUrl = 'http://search.twitter.com/search.json?q=javascriptmvc&count=30';
		$.ajax({
			url: twitterUrl,
			dataType: 'jsonp',
			success: this.callback('insertTwitterFeed')
		});
	},
	insertTwitterFeed : function(results){
		var renderedTweets = [];
		var tweets = [];
		var data = results.results;
		for(var i = 0, ii = data.length; i < ii; i++){ //Filter out direct replies
			var tweet = data[i];
			if(tweet.text.charAt(0) != '@' && tweets.length < 6){
				var formattedDate = this.formatDate(tweet.created_at);
				var renderedTweet = $.String.sub(this.template, {tweet: this.linkify(tweet.text), date: formattedDate, user: "<a href=\"http://twitter.com/" + tweet.from_user + "\">" + tweet.from_user + '</a>'});
				if($.inArray(tweet.text, renderedTweets) == -1){ //Filter out retweets
					tweets.push(renderedTweet);
					renderedTweets.push(tweet.text);
				}
				
			}
		}
		this.element.html('<ul class="tweets">' + tweets.join('') + '</ul>');
	},
	linkify : function(text){
		var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
		return text.replace(exp,"<a href='$1'>$1</a>");
	}
});


$('.sign-in-button').click(function(){
	var klass = 'sign-in-button-active';
	if($(this).hasClass(klass)){
		$(this).removeClass(klass);
		$('.sign-in-popup').hide();
	} else {
		$(this).addClass(klass);
		$('.sign-in-popup').show();
	}
})

$('.preview-post').click(function(){
	if($(this).parent().hasClass('has-preview-post')){
		$(this).parent().removeClass('has-preview-post');
	} else {
		var converter = new Showdown.converter();
		var html = converter.makeHtml($('#post_body').val());
		$(this).siblings('.post-body').html(html);
		$(this).parent().addClass('has-preview-post');
	}
})


function withCsrf(h){
	h[$('meta[name="csrf-param"]').attr('content')] = $('meta[name="csrf-token"]').attr('content');
	return h;
}
$('.user-in-listing').user_administration();
$('.post-in-listing').post_administration();
$('#twitter-feed').twitter_feed();

$('pre').addClass('language-javascript');
hljs.initHighlightingOnLoad();