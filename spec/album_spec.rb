require 'rspec'
require 'pry'
require 'album'

describe '#Album' do

  before(:each) do
    Album.clear()
  end

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an album") do
      album = Album.new("Giant Steps", "The Black Keys", "Rock", "2019", nil) # nil added as second argument
      album.save()
      album2 = Album.new("Blue", "The berries", "Rap", "2020", nil) # nil added as second argument
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end


  describe('.clear') do
    it("clears all albums") do
      album = Album.new("Giant Steps", "The Black Keys", "Rock", "2019", nil)
      album.save()
      album2 = Album.new("Blue", "The berries", "Rap", "2020", nil)
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end


  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new("Blue", "The berries", "Rap", "2020", nil)
      album2 = Album.new("Blue", "The berries", "Rap", "2020", nil)
      expect(album).to(eq(album2))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new("Giant Steps", "The Black Keys", "Rock", "2019", nil)
      album.save()
      album2 = Album.new("Blue", "The berries", "Rap", "2020", nil)
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new("Giant Steps", "The Black Keys", "Rock", "2019", nil)
      album.save()
      album.update("A Love Supreme")
      expect(album.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new("Giant Steps", "The Black Keys", "Rock", "2019", nil)
      album.save()
      album2 = Album.new("Blue", "The berries", "Rap", "2020", nil)
      album2.save()
      album.delete()
      expect(Album.all).to(eq([album2]))
    end
  end

  describe('.search') do
    it("searches an album by name") do
      album = Album.new("Giant Steps", "The Black Keys", "Rock", "2019", nil)
      album.save()
      album2 = Album.new("Blue", "The berries", "Rap", "2020", nil)
      album2.save()
      expect(Album.search("Blue")).to(eq(2))
    end
  end

  describe('.sort') do
    it("sorts albums by name") do
      album = Album.new("Giant Steps", "The Black Keys", "Rock", "2019", nil)
      album.save()
      album2 = Album.new("Blue", "The berries", "Rap", "2020", nil)
      album2.save()
      expect(Album.sort_albums).to(eq([album2, album]))
    end
  end

  describe('#songs') do
    it("returns an album's songs") do
      album = Album.new("Giant Steps", nil, nil, nil, nil)
      album.save()
      song = Song.new("Naima", album.id, nil, nil, nil)
      song.save()
      song2 = Song.new("Cousin Mary", album.id, nil, nil, nil)
      song2.save()
      expect(album.songs).to(eq([song, song2]))
    end
  end
end