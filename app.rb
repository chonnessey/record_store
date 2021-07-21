require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')

get('/test') do
  @something = "this is a variable"
  erb(:whatever)
end

get('/') do
  @albums = Album.all
  erb(:albums)
end

get('/albums') do
  @albums = Album.all
  erb(:albums)
end

post('/albums') do
  name = params[:album_name]
  artist = params[:artist]
  genre = params[:genre]
  year = params[:year]
  album = Album.new(name, artist, genre, year, nil)
  album.save()
  @albums = Album.all()
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  if params[:search] != nil
    item = params[:search]
    album_id = 0
    album_id = Album.search(item)
    if album_id != 0
      @album = Album.find(album_id)
      erb(:album)
    else
      @albums = Album.all
      @bad_result = "try again, album doesn't exist"
      erb(:albums)
    end
  else
    @album = Album.find(params[:id].to_i())
    erb(:album)
  end
end

post('/albums') do
  "This route will add an album to our list of albums. We can't access this by typing in the URL. In a future lesson, we will use a form that specifies a POST action to reach this route."
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  @albums = Album.all
  erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

post('/albums/:id/songs') do
  @album = Album.find(parms[:id].to_i())
  song = Song.new(params[:song_name], @album.id, nil, nil, nil)
  song.save()
  erb(:album)
end

patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/custom_route') do
  "We can even create custom routes, but we should only do this when needed."
end