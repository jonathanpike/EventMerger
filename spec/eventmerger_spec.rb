require 'spec_helper'

describe EventMerger do
  describe "#merge!" do 
    before(:example) do 
      @example_1 = EventMerger.new([{date: '2014-01-01', a: 5, b:1}, {date: '2014-01-01', xyz: 11},
                                    {date: '2014-10-10', qbz: 5}, {date: '2014-10-10', v: 4, q: 1, strpm: -99}]).merge!
      @example_2 = EventMerger.new([{date: '2016-01-01', a: 1, b: 2}, {date: '2016-01-01', c: 3, d: 4, e: 5}, 
                                    {date: '2016-01-01', f: 17, g: 15391}, {date: '2016-01-01', h: 'foo', i: 'bar', j: 'baz'},
                                    {date: '2016-01-02', a: 1, b: 2}, {date: '2016-01-02', c: 64, d: 1324, e: -123, f: 56},
                                    {date: '2016-01-03', m: 37, n: 236509, o: -1351352, g: 'foobar'}]).merge!
      @example_3 = EventMerger.new([{date: '01-01-2016', a: 2, b: 3}, {date: '2016-01-01', c: 4, d: 5}]).merge!
      @example_4 = EventMerger.new([{date: '2016-01-01', a: 1, b: 2}, {date: '2016-01-01', a: 3, b: 4}, 
                                    {date: '2016-01-01', a: 5, b: 6}]).merge!
    end 

    it "should return an array of hashes" do 
      expect(@example_1).to be_kind_of(Array)
      expect(@example_2).to be_kind_of(Array)

      @example_1.each do |hash|
        expect(hash).to be_kind_of(Hash)
      end

      @example_2.each do |hash|
        expect(hash).to be_kind_of(Hash)
      end 
    end

    it "should return 2 hashes in the array for example 1" do
      expect(@example_1.count).to eq(2)
    end

    it "should return 3 hashes in the array for example 2" do 
      expect(@example_2.count).to eq(3)
    end 

    it "should return the correct keys for each hash for example 1" do
      expect(@example_1[0].keys).to eq([:date, :a, :b, :xyz])
      expect(@example_1[1].keys).to eq([:date, :qbz, :v, :q, :strpm])
    end

    it "should return the correct keys for each hash for example 2" do 
      expect(@example_2[0].keys).to eq(%i(date a b c d e f g h i j))
      expect(@example_2[1].keys).to eq(%i(date a b c d e f))
      expect(@example_2[2].keys).to eq (%i(date m n o g))
    end

    it "should return the dates in the same format" do 
      expect(@example_3[0][:date]).to eq("2016-01-01")
    end

    it "should create an array of values if the key already exists" do 
      expect(@example_4[0]).to eq({date: '2016-01-01', a: [1, 3, 5], b: [2, 4, 6]})
    end 

    it "should raise an ArgumentError if arguments aren't in an Array" do 
      expect{ EventMerger.new("False") }.to raise_error(ArgumentError)
    end

    it "should raise an ArgumentError if the Events aren't in a hash" do 
      expect { EventMerger.new(["false"]).merge! }.to raise_error(ArgumentError)
    end

    it "should raise an ArgumentError if no dates provided" do
      expect { EventMerger.new([{d: 1}, {m: 2}]).merge! }.to raise_error(ArgumentError)
    end 
  end 
end
