enum AuthMode {
  SignUp,
  Login,
}


/*
mixin ReflectModel on ConnectedNewsModel {
  List<Reflect> get allReflects {
    return List.from(_reflects);
  }

  List<Reflect> get displayedProducts {
//    if (_showFavorites) {
//      return _products.where((Product product) => product.isFavorite).toList();
//    }
    return List.from(_reflects);
  }

  int get selectedReflectIndex {
    return _reflects.indexWhere((Reflect reflect) {
      return reflect.reflectID == _selReflectId;
    });
  }

  String get selectedReflectId {
    return _selReflectId;
  }

  Reflect get selectedReflect {
    if (selectedReflectId == null) {
      return null;
    }

    return _reflects.firstWhere((Reflect reflect) {
      return reflect.reflectID == _selReflectId;
    });
  }

  Future<bool> addReflect(String title, String description) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> ReflectData = {
      'title': title,
      'description': description
    };

    try {
      final http.Response response =
      await http.post('http://68.183.187.228/api/reflects',
          headers: {
            'Content-Type': 'application/json',
            'Auth-Token': _authenticatedUser.token,
          },
          body: json.encode(ReflectData));

      print(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      final Reflect newReflect = Reflect(
        reflectID: responseData['name'],
        title: title,
//            reflectID : responseData['id'],
        description: description,
//            userEmail: _authenticatedUser.email,
//            userId: _authenticatedUser.id
      );
//        print(newReflect.id);
      _reflects.add(newReflect);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateReflect(String title, String description) async {
    _isLoading = true;
    notifyListeners();
    print('${selectedReflect.id}');
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
//        'image':
//        'https://upload.wikimedia.org/wikipedia/commons/6/68/Chocolatebrownie.JPG',
//        'price': price,
//        'userEmail': selectedProduct.userEmail,
//        'userId': selectedProduct.userId
    };
    return http
        .put('http://68.183.187.228/api/reflects/${selectedReflect.id}',
        headers: {
          'Content-Type': 'application/json',
          'Auth-Token': _authenticatedUser.token,
        },
        body: json.encode(updateData))
        .then((http.Response response) {
      print('${selectedReflect.reflectID}');
      _isLoading = false;
      final Reflect updatedReflect = Reflect(
        reflectID: selectedReflect.reflectID,
        title: title,
        id: selectedReflect.id,
        description: description,
//            image: image,
//            price: price,
//            userEmail: selectedProduct.userEmail,
//            userId: selectedProduct.userId
      );
//        print('http://68.183.187.228/api/reflects/${selectedReflect.id}');
      _reflects[selectedReflectIndex] = updatedReflect;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteReflect() {
    _isLoading = true;
    print(selectedReflect.id);
    final deletedReflectId = selectedReflect.id;
    print(deletedReflectId);
    _reflects.removeAt(selectedReflectIndex);
    _selReflectId = null;
    notifyListeners();
    return http.delete(
      'http://68.183.187.228/api/reflects/${deletedReflectId}',
      headers: {
        'Content-Type': 'application/json',
        'Auth-Token': _authenticatedUser.token,
      },
    ).then((http.Response response) {
      print(response.body);
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchReflects() {
    _isLoading = true;
    notifyListeners();
    return http.get(
      'http://68.183.187.228/api/reflects/',
      headers: {'Auth-Token': _authenticatedUser.token},
    ).then<Null>((http.Response response) {
      final List<Reflect> fetchedReflectList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Reflect product = Reflect(
          reflectID: productId,
          title: productData['title'],
          description: productData['description'],
          id: productData['id'],
//            image: productData['image'],
//            price: productData['price'],
//            userEmail: productData['userEmail'],
//            userId: productData['userId']
        );
        fetchedReflectList.add(product);
      });
      _reflects = fetchedReflectList;
      _isLoading = false;
      notifyListeners();
      _selReflectId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  void selectReflect(String reflectId) {
    _selReflectId = reflectId;
    notifyListeners();
  }
}*/
