SELECT COUNT(DISTINCT user_Id) AS total_users_downloaded_clips
FROM downloaded_clips;

SELECT COUNT(clips_id) AS total_clips_downloaded
FROM downloaded_clips;

SELECT COUNT(DISTINCT gamesession_Id) AS total_gamesessions_for_downloaded_clips
FROM downloaded_clips;

SELECT COUNT(DISTINCT user_id) AS total_premium_users
FROM premium_users
WHERE STRFTIME('%Y-%m-%d', SUBSTR(starts_at, INSTR(starts_at, '/') + 1)) BETWEEN '2023-09-19' AND '2023-12-19';


