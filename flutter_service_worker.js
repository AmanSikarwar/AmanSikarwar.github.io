'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "ce5a4127a53dae46f7f1dcf1826a36b7",
"version.json": "7cc527ed79f3d4fa2a39f1545b3ba256",
"index.html": "0a28edfa0c3dbb80d2fd77681fea652f",
"/": "0a28edfa0c3dbb80d2fd77681fea652f",
"main.dart.js": "cb5709ef6f8bab9ddaf49519e947f78d",
"flutter.js": "1e28bc80be052b70b1e92d55bea86b2a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.mjs": "7067b10af503214c844dd138bd8a6f7c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "884ed368dd3439ac9fa178253ae152d9",
"main.dart.wasm": "8620d91dd4ed150d2d4e8582a8e1bcb9",
".git/config": "7d97bf21b1bf23b9e35ed0f2da228c86",
".git/objects/0d/32fcaf4a0c8a6f71b8adf81fb986047ae206f6": "86b0f758b2b0e172460f933913ae8008",
".git/objects/95/26bffeb4ddd09073236dd44387b21861fb86ed": "1fddc2fada96cb9f87398d2d84078719",
".git/objects/50/08ddfcf53c02e82d7eee2e57c38e5672ef89f6": "d18c553584a7393b594e374cfe29b727",
".git/objects/68/132e4494a4ddb804a461de8fa5dea26b8343e8": "d11a91483c520fc66d97b65e1fdf9dc9",
".git/objects/03/efc56929243cf0c6393eff55997f2a30af27d0": "fda4dc1ae3fc08fe86db2754b7e0825f",
".git/objects/9b/d3accc7e6a1485f4b1ddfbeeaae04e67e121d8": "784f8e1966649133f308f05f2d98214f",
".git/objects/0e/b1588ed879454744781b55c97e25b50e653b7a": "0dd182ee3feb02457de6ab6ae86b8f74",
".git/objects/60/945552bd06b85d105d518f010895ae6484df84": "da8e38cae534d3b7f2d9fe23f3f14c8e",
".git/objects/34/52ab08ef62f853e6d5176bb5cea8db5250b173": "1e2bf1da14dcab303cba9b9266fda08b",
".git/objects/5f/eba15bc8dd0ba38241c0cb0c19da36a9d8f214": "733323f124ace08f45861e62f6cdec19",
".git/objects/9c/e79b129da4789690c893e5e0edb105c1b93354": "6e7f3da51a7a1eb2da2f82f5f520050a",
".git/objects/a3/7fd6f7b6c06604f8a1541e74cb928efa5eb073": "6df733bf2193f494d9c0cf6b143dce8e",
".git/objects/b5/e70c908857d574ab6d41953a516e4c811c969b": "27259c13acc82b1f972a32ec74cd4b27",
".git/objects/da/8418cb4256170dd235ea3967b766668218ce16": "dc8bc866fa6497b9e477648e2cc74b1f",
".git/objects/a5/2752f728f7977ea0dc8ca9476d3841e6afb262": "4bc9dc37d4625c1c8646effd0963c395",
".git/objects/d1/abe292c2c7687aeb0c966a1675574f34808029": "b4d2cc94c030ebde7b134a9d8344d38a",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d6/68eb3d738787eb02afe5706ed284eb2c04a7ad": "18e97130bf460c9cb40a6d8f61552d7f",
".git/objects/ae/2787c833b6c288a56ffff4ac2af96a64dabb81": "26c419062d1870b7235f7f901e9428c1",
".git/objects/ab/d846a31fb23884990528f04e71a8ce6af23e93": "ce569922fbbcd06d64590dcf6376e157",
".git/objects/e5/47b902d6ff8401af04040dd35da94874e200a5": "84a5593eaf76a9a79b81f1962f0a3f8b",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/c7/c5aafed8415aa2470c8000c1b80c6ff3fd9026": "169227982b342950f055de3fd35a27be",
".git/objects/c7/8e9b9a07392294ea9f8bae5284ca898c78a2e4": "fc1c7a8f4b5a7f8d88e6e8a45a6732cd",
".git/objects/fc/df71028e70575d71d550fd1eb8dd7c2793c11b": "ac73c334960e7d01b578c56f8f4c82df",
".git/objects/fd/40d37ea9f60ace22c0c769c22ce3c00644b203": "ef59a72d4520072389a900217f1d2d33",
".git/objects/fd/40bef78133377472d17440f1a340eb6aa3a064": "b6b186172345ecf11d0cbda6717c8d07",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/fb/d41675ab5844304f507670bca43d23e5d8f4a6": "4b629e246b870a61325125241688d618",
".git/objects/c1/9595d6671bea6bb2995fc63a66b8e683eac937": "37b88efd3672ce4f86eee53b33fb874d",
".git/objects/ec/5e1c19fa9206695efefface7527bc54c8b435f": "0da5876ab3c0645260cbe8a622db79b8",
".git/objects/20/7f4bfce27ae1dd77283f874c28aece65285d02": "82c560f867f4f3ef97dea6ad5492b5bf",
".git/objects/42/7a3aa78bdcac460f18d356b9a68661c60cd5d9": "68d9ed3bda32bfda62d2c73c03f5702f",
".git/objects/80/f7a0ad2825628e88dad94a60096a805bce0ff6": "2777b0f3c25a57e480b1404115e6f676",
".git/objects/80/5e20f8442f10072e17e844ecf5281e64472ec0": "3f1f483c921d668086003c599b715eaa",
".git/objects/74/6edcc411fa9c336b95fe5693bca4b8f995ddbe": "ba704b9392554c62cae875d7049a7589",
".git/objects/1a/854f7747f1cff01785afcd0ed53959b170fed0": "c65b773d50919cedbb73a4353393f49d",
".git/objects/28/1b7530cc785b4471fb53f5c88e21d069081536": "138cc890078f58d9acca294de1fb3b19",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/4c/e36bc0333e1debc1382f23b0a51cfb42d8721e": "e6d2d81e9d9d5de934b35a70c4a49d94",
".git/objects/21/10124127056f45fafb952ce9049df79eb55b61": "b49c3e20af415d25cb23788afae9e0a4",
".git/objects/75/a4e3256968286f7ec1e488284b97abf71132e4": "36f50f4a92d042b52d847876649acad6",
".git/objects/86/352df026ed4318b5fc88b71a2073edf993a911": "fd72092d04fa5e5bb7f8a9cc24d5c6c2",
".git/objects/43/06fe03d255dccb99facb580d2d53bcdc651d94": "9a058f8f1e3471afbd97d81c01ffc203",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/07/ad4503ecdcd8d80502346816cedf9fde6df940": "be56b2b2ae47972947ad714020d435f0",
".git/objects/36/2dfd443d35898d873b2ed38c689fde06f894fd": "f25c366aaefe0ca98615825f39adb00c",
".git/objects/5d/0d319f7781aedae3f9991e569bdb1d23731c19": "b42c4137b119daa27135dc8d0398f9fb",
".git/objects/5d/4610a978cfcc4b287e7a894fecc01d09df7759": "7aefbab5212e5118b10a0b2719db72ac",
".git/objects/98/d39762418a87a94e1c2fe46498899b7e545dbf": "e9767feaaa20121544f70cecb9346316",
".git/objects/98/0303f5c3d39e2a3827616e4414e2370a978c2f": "a834fde1bcfa4daa701d683b4bf72e0e",
".git/objects/53/04ae105638aa56e01db40752783bedc1534079": "19e89e026bdbb4c911692a0ec94747b3",
".git/objects/5e/f8c91daa3ff4d81f9929a7cb82babaae53fae5": "e91ac6939d12bcc94f051e2e2890d6d3",
".git/objects/08/d207d3ed6d6cfa47f0390c5325d96e20e7d4a0": "8de48f607b6a13bb6589c3d2a65acc7c",
".git/objects/6c/495c0ca67fd8dc448ef0645d3436c4b1b0cd6e": "82dd97c086c411f60b41d201076f224a",
".git/objects/6c/6152c96b02341e95bb7b4d97bab06bef73e9fa": "1c56351ec1a043b66aa1de5b58bb5b60",
".git/objects/0f/a4562333480972f569dab1fceb5e694f0cb213": "2caa95d46e1e95605479525878470798",
".git/objects/90/0f7aea17bd76a0fa107fc200337224f1a204b1": "252c131cf79af0e5d29a8a4537a40d66",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/a7/4c088ca2553999f95909526806a72c738e399e": "9cdb239c2e0f32bd7f824871023be8d3",
".git/objects/dd/97a738f56f99f4b64e05ac1fb3467fbc7d1d5c": "9d636b0e505f79e5a9369e669fb10312",
".git/objects/dc/67dd363b44f82d30dc9bd7cf661744278f4dd3": "fedc759dd4ef5de29d7b523f1c03f1a6",
".git/objects/b6/6b7111b7a42b9a3702ca678d67af976076ba14": "d61bc4c41a53fd06b5a7092458e70bd6",
".git/objects/b6/14044415cd4fee1c9aa0ece36730a9098945a5": "a24cc0201894724d5e29e95900fad187",
".git/objects/aa/1898636ef1f44398088c982cbd2064505880ff": "101fd5eeb0b5f35f0192e78c27a11138",
".git/objects/af/8f4aee85b11f30c179320b0b5aec6710b4c710": "0a537293034f289345986d26478a2413",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/d41555eea0777fba75720a67c2651fd2cb0602": "5d775ba1fbd72c813dda319e78f4b7fb",
".git/objects/e1/f87f5ffcd1738c600b36a41d3a2927851cb9ba": "95922687d005d7100aa4030c88760bd8",
".git/objects/ff/1c16b81ec56f15ef6c32e21920aa78b86a7071": "472f03f80d9c0cb6dbe168cf1272272c",
".git/objects/c5/ad95b3b262faeabc2e5b9954d9566392995650": "d39b7374849b0f91c51a123cbccb710a",
".git/objects/cb/edcfcdd040725007a662176aa689a94321e368": "f42d78c28061fb22372f7f332fa1b9de",
".git/objects/ce/18f441b94092bcdb0936e0c5050a398b67b398": "feb243a407bbd88293ed16786566d499",
".git/objects/e0/984a7acd0be287831bb5e0eea48c25fa28670d": "c9d1e01ee8e8c473cb719899cf1c708a",
".git/objects/e0/2a8cb1b4262c4039d2035ab4f9807c6ee12b22": "21d4350eb6f3ba3c7f07a10e0d45ef23",
".git/objects/83/280a4151e30af49623df6b6a404c67720b1ef8": "320d7a486d64040b2fbebc8712e1fca9",
".git/objects/70/a234a3df0f8c93b4c4742536b997bf04980585": "d95736cd43d2676a49e58b0ee61c1fb9",
".git/objects/70/920a85d252eab190abc64b73ba9799aa456b76": "d5ffede4ed7ae0357eaa67bff46800f9",
".git/objects/84/c0b82005f5a55d1e09a31f42d01e9223403b47": "dc200753d2ef3f1cff28313ac8ecac65",
".git/objects/24/0b87fb0718a4ae5f540fb1d2de7b4360bc92c6": "0c08700e6dc80a48ccc5bb91d0738e39",
".git/objects/8d/e48e06fb2d3e81ebe85d45b5c045642b906658": "c3b09b6ff800668a1332f2ab892a87a8",
".git/objects/12/674503b2157e00e0ffca6a1616fe9646725178": "194c029e4d60dd695bd29709c063921e",
".git/objects/71/6a6f64f25d49c3cbf8c01be987024a8617027f": "bf4eb706f94643eb4213f2082a388d38",
".git/objects/1c/4362b9bfc063638b87e3c4f8404ad49d402e12": "60167853393179c66a7e5345b256714b",
".git/objects/82/6a76883cc5860591bb9c646ec29ffec4dec98a": "3853dad124db77b6edb7ee9409b49442",
".git/objects/49/ddeb6630fa510d8152c3f17589f3e34283d480": "62057dbb6de71f5c2d6c49e99d93a873",
".git/objects/2b/4b403225d72efcf25f3ca66aaf6f09fa05c2da": "27d5dbd5354fc57329fb15c43fac3cd1",
".git/objects/47/ab6feedcf1eb96b7505c020f81d785255b9007": "c791786412e9f90d2cbd2baa617dcb7e",
".git/objects/78/04015a7f30ce1506a75ce02efa429897faf44e": "7e0c040854002f5297e0d44d56e34a56",
".git/objects/8b/c41272674949f379ec0a6f2baaecec640714a8": "be464ebb5d8dabfea4dab5de99123bbd",
".git/objects/8e/1bb33213126ab41fe559e8067117b9853c9c17": "482ee3dd60670f9b621e5378bd1ce590",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "8cbf050321f091d4c89c2b694d09059b",
".git/logs/refs/heads/main": "684f8f9901d9e1bb86d85b36d4772e54",
".git/logs/refs/remotes/origin/main": "10692115607bc585fbd51718cd9bfb71",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/main": "d2ff304926d64344e3d9ee82d7400881",
".git/refs/remotes/origin/main": "d2ff304926d64344e3d9ee82d7400881",
".git/index": "9144ab563b6e9309345d526e47b6059a",
".git/COMMIT_EDITMSG": "d6edff0b1766c54f66050bfd43bdcd4c",
"assets/AssetManifest.json": "6e6d5fd34366d74979809cd22924b779",
"assets/NOTICES": "f5f070a933e1f16a9fd81b872a617f75",
"assets/FontManifest.json": "3ddd9b2ab1c2ae162d46e3cc7b78ba88",
"assets/AssetManifest.bin.json": "efe0ef6b0658626e4cd87ff1337f9fd3",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "d51d688ef3e9d20497dba240e3f9e923",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "615f43d7e808549b3a8c059b6caae5af",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "f4fbc3920640564a202bc5686fbd6db7",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "504fa5a5bd8dca37fa8060ad52361e0d",
"assets/fonts/MaterialIcons-Regular.otf": "552e5251443870f7f836b51e21b573eb",
"assets/assets/Aman%2520Sikarwar.png": "528b89a7e6957fede48b210569a504d0",
"canvaskit/skwasm_st.js": "7df9d8484fef4ca8fff6eb4f419a89f8",
"canvaskit/skwasm.js": "9c817487f9f24229450747c66b9374a6",
"canvaskit/skwasm.js.symbols": "1ab725c865730c55a05037504aa49e63",
"canvaskit/canvaskit.js.symbols": "92118ac9c289955646a0baff4199e361",
"canvaskit/skwasm.wasm": "6bcbf3d848c812d9db0a501a43a14505",
"canvaskit/chromium/canvaskit.js.symbols": "df8d59c9c5b939138218728e60fda285",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f53b08798252647c4453cf5c6aac7369",
"canvaskit/skwasm_st.js.symbols": "9e3ded5c33a28acd40a6bf325038b3cf",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "3b15ffefc3ea26bd4b3d31edd5f2aadc",
"canvaskit/skwasm_st.wasm": "f53ddcaeacd1ccd08530e1d5a0f20f4c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
