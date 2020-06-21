# iOS, Server Communication

## URL

* 특별한 상황을 제외하고는 head에 unique한 값(client_id, user_id, token 등)이 항상 들어간다.
* POST 메서드에서는 Parameter를 최대한 활용하도록 한다.



## Article

1. Article 올릴 때 일어나는 일
   1. 현재 위치 데이터**(n_lat, n_lon) zoom_level**을 뽑는다.
   2. n_lat, n_lon(현재위치의 lat, lon) 과 reverse geocoding을 이용해 현재 위치의 **Geo Names**  를 받아온다.
   3. GeoNames 을 다시 geocoding 하여 g_gps(g_lat, g_lon 쌍으로 된 list) 을 뽑아낸다.**(g_lat, g_lon은 주소의 lat, lon)**
   4. g_gps 에 zoom_level을 매핑한다. 각 zoom_level에 따른 g_lat, g_lon을 반환할 수 있도록...
   5. server에 넘겨줄 데이터는 다음과 같다.
      * user_id(Int)
      * article_id(Int)
      * contents (String url)
      * n_lat (Double)
      * n_lon(Double)
      * g_gps(json list)
        * zoom_level(Int)
          * region_name(String)
          * g_lat(Double)
          * g_lon(Double)
2. ㅇ



## Map 

### GistList

url: https://host/1/gist_list

**dependency: zoom_level에 따른 hot_article set이 필요함**

1. Client에서 Server에 요청한다.
   * Param
     * 현재위치의 lat(Double) => **n_lat**
     * 현재위치의 lon(Double) => **n_lon**
     * 현재 zoom level(Int) => **zoom_level**
2. Server에서 하는 일은 다음과 같다.
   1. n_lat, n_lon, zoom_level 으로 **Boundary(gistlist를 가져오는데 현재 얼마만큼의 범위를 search할 것인지)**를 정해서 kml에서 뽑아올 **dataSet**을 정한다.
      * Boundary search
        1. zoom_level을 이용해 **boundaryValue** 를 정한다.( boundaryValue는 zoom_level에 따른 boundary 반경 값이다.)
        2. zoom_level과 boundaryValue를 이용해 **hot_article**을 가져온다.
        3. hot_article의 이용해 zoom_level에 따른 **article**을 가져온다.
        4. article과 zoom_level을 이용해 **g_lat, g_lon, region_name**을 가져온다.
        5. boundary내에 있는  g_lat, g_lon, region_name을 dataSet에 넣는다.
   2. dataSet에 있는 region_name으로 gist_dataSet 을 정한다.
   3. client에 넘겨줄 데이터는 다음과 같다.
      * (json list)
        * gist_dataSet 에 있는 gist_list(double list)
        * g_lat, g_lon(Double)
        * region_names( json list)
          * dataSet에 있는 region_name(String)
            * // 이 부분 CollectionView에 올릴 용도로 쓰일 건데 boundary 내에 있는 article 만 사용할건지? 
        * article_id(추후 논의)
        * user_id(추후 논의) => article에 대한 소유 user_id

