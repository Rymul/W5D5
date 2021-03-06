def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between 3 and 5
  # (inclusive). Show the id, title, year, and score.
  Movie.select('movies.id, movies.title, movies.yr, movies.score').where('yr >= (?) AND yr <= (?) AND score >= (?) AND score <= (?)', 1980, 1989, 3, 5)

  # or
  # Movie.select('movies.id, movies.title, movies.yr, movies.score').where(yr: 1980..1989, score: 3..5)

end

def bad_years
  # List the years in which no movie with a rating above 8 was released.
  Movie.group('movies.yr').having('MAX(movies.score) <= 8').pluck('movies.yr')
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor.select('actors.id, actors.name').joins(:movies).where('movies.title = (?)', title).order('castings.ord ASC')
end

def vanity_projects
  # List the title of all movies in which the director also appeared as the
  # starring actor. Show the movie id, title, and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie.select('movies.id, movies.title, actors.name').joins(:actors).where('movies.director_id = castings.actor_id AND castings.ord = (?)', 1)
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name, and number of supporting roles.
  Actor.select('actors.id, actors.name, COUNT(castings.actor_id) AS roles').joins(:castings).group('actors.id').where.not('castings.ord = (?)', 1).order('roles DESC').limit(2)
end