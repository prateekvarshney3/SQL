use ig_clone;
# Q2 We want to reward the user who has been around the longest, Find the 5 oldest users.
select username,created_at from users order by created_at limit 5;

# Q3 To understand when to run the ad campaign, figure out the day of the week most users register on?
select count(*) as maximum_count  ,(dayname(created_at)) as user_registered_day from users 
group by user_registered_day order by count(*) desc limit 2;

# Q4 To target inactive users in an email ad campaign, find the users who have never posted a photo.
select users.id,username from users
left join photos on users.id = photos.user_id
where photos.user_id is null order by users.id;

# Q5 Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
select u.id,u.username,l.photo_id, count(*) as total_likes from likes l join users u on l.user_id=u.id
group by l.photo_id order by total_likes desc limit 1;

# Q6 The investors want to know how many times does the average user post.
select ceil(((select count(*) from photos) / (select count(*) from users))) as average_user_post;

# Q7 A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select tag_id, tag_name,count(*) as total_count from photo_tags pt join tags t on pt.tag_id=t.id
group by tag_id order by total_count desc limit 5;

# Q8 To find out if there are bots, find users who have liked every single photo on the site.
select  user_id, username as users_liked_every_photo,count(*) as total from likes l join users u on l.user_id=u.id
group by user_id having total=(select count(*) from photos) order by total desc;

# Q9 To know who the celebrities are, find users who have never commented on a photo.
select u.id, username as celebrities from users u left join comments c on u.id=c.user_id
where c.comment_text is null order by u.id;

# Q10 Now it's time to find both of them together, find the users who have never commented on any photo 
# or have commented on every photo.
select u.id, username as celebrities from users u left join comments c on u.id=c.user_id
where c.comment_text is not null
union 
select u.id, username as celebrities from users u left join comments c on u.id=c.user_id
where c.comment_text is null

 