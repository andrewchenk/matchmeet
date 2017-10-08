########### Python 3.6 #############
import http.client, urllib.request, urllib.parse, urllib.error, base64, json
import sys

###############################################
#### Update or verify the following values. ###
###############################################

# Read images url from stdin
# Replace the subscription_key string value with your valid subscription key.
subscription_key = '35b0725209e04bb187f8b512e935cc3d'

urls =[
    "https://stillmed.olympic.org/media/Photos/2016/08/14/part-2/14-08-2016-tennis-doubles-mixed-04.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Football_cross.jpg/220px-Football_cross.jpg", #football
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/College_soccer_yates_iu_v_tulsa_2004.jpg/1200px-College_soccer_yates_iu_v_tulsa_2004.jpg",
    "https://i.ytimg.com/vi/a6fSBnkfleA/maxresdefault.jpg", #table tennis
    "http://www.ambientegallerie.com/blog/wp-content/uploads/2016/07/swimming.jpg",
    "http://media.istockphoto.com/photos/four-people-taking-part-in-cooking-class-picture-id498615802",
    "https://libwww.freelibrary.org/assets/images/programs/reading.jpg",
    "https://qph.ec.quoracdn.net/main-qimg-6039724e28f7bb2d3679f594ac214706-c", #studying
    "https://s3-eu-west-1.amazonaws.com/trescoisland/images/Eating/Landing_page/Tresco_Island-Eating_Ruin_1200x858_1.jpg",
    "http://www.apa.org/Images/therapy-group-title-image_tcm7-162394.jpg",
    "https://snowkingmountain.com/wp-content/uploads/2015/10/biking-miles-of-pathways-in-jackson-hole-1024x683.jpg", #biking
    "http://www.telegraph.co.uk/content/dam/Gardening/Spark/B&Q/lady-gardening-xlarge.jpg",
    "https://i.pinimg.com/originals/e3/17/00/e3170082c507b1263d9e47f28c318013.jpg", #movie
    "https://cdn.pixabay.com/photo/2013/12/30/00/20/ice-skating-235547_1280.jpg",
    "http://www.fayetteville-ar.gov/ImageRepository/Document?documentID=12034", #frisbee
    "https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/05/24/15/picnic-baskets-lifestyle-2-0.jpg",
    "https://cf.geekdo-images.com/R3tD3P1aOdBq-XlIZDu_OZCk9nU=/fit-in/1200x630/pic260745.jpg" #chess
]

# Replace or verify the region.
#
# You must use the same region in your REST API call as you used to obtain your subscription keys.
# For example, if you obtained your subscription keys from the westus region, replace
# "westcentralus" in the URI below with "westus".
#
# NOTE: Free trial subscription keys are generated in the westcentralus region, so if you are using
# a free trial subscription key, you should not need to change this region.
uri_base = 'westcentralus.api.cognitive.microsoft.com'

headers = {
    # Request headers.
    'Content-Type': 'application/json',
    'Ocp-Apim-Subscription-Key': subscription_key,
}

params = urllib.parse.urlencode({
    # Request parameters. All of them are optional.
    'visualFeatures': 'Categories,Description,Color',
    'language': 'en',
})

tags = set()

def analyzeImage(url):
    # Replace the three dots below with the URL of a JPEG image of a celebrity.
    print(url);
    body = "{'url': '" + url + "'}"

    try:
        # Execute the REST API call and get the response.
        conn = http.client.HTTPSConnection('westcentralus.api.cognitive.microsoft.com')
        conn.request("POST", "/vision/v1.0/analyze?%s" % params, body, headers)
        response = conn.getresponse()
        data = response.read()

        # 'data' contains the JSON data. The following formats the JSON data for display.
        parsed = json.loads(data)
        for e in parsed['description']['tags']:
            tags.add(e)
        conn.close()

    except Exception as e:
        print('Error:')
        print(e)

for image in urls:
    analyzeImage(image)
print(sorted(list(tags)))

# out = ['air', 'ball', 'beach', 'bench', 'bicycle', 'bird', 'blue', 'board', 'boat', 'body', 'boy', 'building', 'cake', 'cellphone', 'child', 'coffee', 'colorful', 'computer', 'control', 'counter', 'court', 'covered', 'crowd', 'cup', 'desk', 'dog', 'doing', 'drink', 'drinking', 'eating', 'female', 'field', 'flower', 'flying', 'food', 'frisbee', 'front', 'fruit', 'game', 'garden', 'girl', 'glass', 'glasses', 'grass', 'grassy', 'green', 'group', 'gymnastics', 'hand', 'hill', 'holding', 'hydrant', 'indoor', 'kitchen', 'kite', 'laptop', 'large', 'laying', 'little', 'looking', 'luggage', 'man', 'many', 'match', 'meal', 'mountain', 'object', 'ocean', 'orange', 'outdoor', 'paper', 'park', 'people', 'person', 'phone', 'pizza', 'plate', 'player', 'playing', 'pool', 'racket', 'red', 'restaurant', 'riding', 'road', 'room', 'row', 'shirt', 'sitting', 'skiing', 'slope', 'small', 'smiling', 'snow', 'soccer', 'sport', 'standing', 'street', 'surfing', 'swimming', 'swinging', 'table', 'talking', 'team', 'tennis', 'thing', 'top', 'trail', 'using', 'video', 'walking', 'water', 'wave', 'wearing', 'white', 'wii', 'window', 'woman', 'yellow', 'young']

tags = ['ball', 'beach', 'bicycle', 'bird', 'boat', 'coffee',
'computer','dog', 'drink',  'eating', 'field', 'flower', 'flying', 'food',
'frisbee', 'fruit', 'game', 'garden', 'glass', 'grass', 'green', 'gymnastics',
'hill', 'indoor', 'kitchen', 'kite', 'laptop', 'mountain', 'ocean', 'outdoor', 'park', 'phone',
'player', 'pool', 'racket', 'restaurant', 'riding', 'road', 'room', 'sitting', 'skiing', 'snow',
 'soccer', 'sport', 'surfing', 'swimming', 'swinging', 'table', 'talking', 'team', 'tennis', 'trail',
  'video', 'walking', 'water', 'wii']

####################################
