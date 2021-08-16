require 'csv'
# require 'pry'
require 'geojson_model'

features = []
dog = {}
CSV.foreach('geosphaera.csv', :headers => true, :col_sep => ",") do |row| 
    latitude = row['origin_latitude']
    longitude = row['origin_longitude']
    g = GeojsonModel::Geometry.new(type: 'Point', coordinates: [longitude.to_f, latitude.to_f])
    f = GeojsonModel::Feature.new(properties: {
        "origin_id": row['origin_id'],
        "origin_city": row['origin_place'],
        "origin_lon": row['origin_longitude'],
        "origin_lat": row['origin_latitude'],
        "destination_id": row['destination_id'],
        "destination_city": row['destination_place'],
        "destination_lon": row['destination_longitude'],
        "destination_lat": row['destination_latitude'],
        "origin_begindate": row['origin_begindate'],
        "destination_enddate": row['destination_enddate'],
        "origin_name": row['origin_name'],
        "destination_name": row['destination_name'],
        "note_description": row['note_description']
        }, geometry: g)
        puts f.to_json
        # dog = f.to_h
        # fc = GeojsonModel::FeatureCollection.new(features: [dog])
        # puts fc.to_json
end