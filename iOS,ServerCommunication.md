# iOS, Server Communication

## URL

* 특별한 상황을 제외하고는 head에 unique한 값(client_id, user_id, token 등)이 항상 들어간다.
* POST 메서드에서는 Parameter를 최대한 활용하도록 한다.



## Map 

### GistList

url: https://host/1/gist_list

1. Client에서 Server에 요청한다.
   * Param
     * 현재위치의 lat(Double) => **client_lat**
     * 현재위치의 lon(Double) => **client_lon**
     * 현재 zoom level(Int) => **zoom_level**
     * 현재 zoom 상태(String) -> ex) "Jangan-gu" 또는 "Suwon-si" => **zoom_status**
2. Server에서 하는 일은 다음과 같다.
   1. client_lat, client_lon, zoom_level 으로 **Boundary(gistlist를 가져오는데 현재 얼마만큼의 범위를 서칭할 것인지)**를 정해서 kml에서 뽑아올 **dataSet**을 정한다.
   2. 1번에서 정한 dataSet 중 zoom_level 에 맞는 **collectionName**을 정한다. (NAME_0, NAME_1, NAME_2 중에 1개)
   3. Geocoding과 collectionName을 활용하여 그 지역의 **g_lat, g_lon**을 받아온다.
   4. client에 넘겨줄 데이터는 다음과 같다.
      * (json list)
        * dataSet 에 있는 gist_list(double list)
        * g_lat, g_lon(Double)
        * dataSet에 있는 collectionName(String)
        * article_id(추후 논의)
        * user_id(추후 논의)

