import '../api_client.dart';
import '../api_endpoints.dart';
import '../api_response.dart';

class ProductApiService {
  ProductApiService._();

  // =========================================================
  // ADD PRODUCT TO CONFIGURATOR
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> addOrder({
    required String productId,
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    switch (productId) {
    // -------------------------------------------------------
    // MIGHTY LUBE CC5 CHAIN LUBRICATOR
    // -------------------------------------------------------

      case 'CC5_CL':
        return _addCC5ChainLubricator(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // CC5 OP-40E
    // -------------------------------------------------------

      case 'CC5_OP40E':
        return _addCC5Op40e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // CATERPILLAR DRIVE LUBRICATORS
    // -------------------------------------------------------

      case 'COE_CDL':
        return _addCaterpillarDriveLubricators(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // MIGHTY LUBE CHAIN ON EDGE LUBRICATOR
    // -------------------------------------------------------

      case 'COE_CEL':
        return _addMightyLubeChainOnEdgeLubricator(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // CATERPILLAR DRIVE OP-40E
    // -------------------------------------------------------

      case 'COE_OP4OE':
        return _addCaterpillarOp40e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETIPO UN91 / RW91
    // -------------------------------------------------------

      case 'ETI_91':
        return _addEtipoUn91(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETIPO 8074-B / 8075-B
    // -------------------------------------------------------

      case 'ETI_807':
        return _addEtipo8074(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETIPO 9000INVL
    // -------------------------------------------------------

      case 'ETI_9000INVL':
        return _addEtipo9000Invl(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETIPO OP-48E
    // -------------------------------------------------------

      case 'ETI_OP48E':
        return _addEtipoOp48e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETOPO 2100L
    // -------------------------------------------------------

      case 'ETO_2100':
        return _addEtopo2100L(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETOPO 9000L
    // -------------------------------------------------------

      case 'ETO_9000E':
        return _addEtopo9000L(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETOPO OP-48E
    // -------------------------------------------------------

      case 'ETO_OP48E':
        return _addEtopoOp48e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETOPO PORTABLE MULTI-LINE MONITORING SYSTEM
    // -------------------------------------------------------

      case 'ETO_PMLMS':
        return _addEtopoPmlms(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETOPO MULTI LINE ALL IN ONE MONITORING + LUBRICATION
    // -------------------------------------------------------

      case 'ETO_MLAIO':
        return _addEtopoMlaio(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // FREE CARRIER - FREE RAIL 314 "LOAD" WHEEL GREASER
    // -------------------------------------------------------

      case 'FC_314':
        return _addFreeCarrier314(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // FREE CARRIER - FREE RAIL 317 "GUIDE" WHEEL GREASER
    // -------------------------------------------------------

      case 'FC_317':
        return _addFreeCarrier317(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // FLAT TOP OPCO 300
    // -------------------------------------------------------

      case 'FT_OPCO':
        return _addFlatTopOpco300(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // MIGHTY LUBE FLAT TOP LUBRICATOR
    // -------------------------------------------------------

      case 'FT_MLCEL':
        return _addFlatTopMightyLubeLubricator(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // FLAT TOP OP-40E
    // -------------------------------------------------------

      case 'FT_OP40E':
        return _addFlatTopOp40e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // C CHANNEL - OVERSPRAY ELIMINATOR BRUSH
    // -------------------------------------------------------

      case 'FRO_OEB':
        return _addCChannelOversprayEliminatorBrush(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // C CHANNEL - FREE RAIL 314 "LOAD" WHEEL GREASER
    // -------------------------------------------------------

      case 'FRO_314':
        return _addCChannelFreeRail314(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // C CHANNEL - FREE RAIL 317 "GUIDE" WHEEL GREASER
    // -------------------------------------------------------

      case 'FRO_317':
        return _addCChannelFreeRail317(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // C CHANNEL - 9000L SERIES CENTRAL SYSTEM
    // FREE CARRIER CONVEYOR LUBRICATORS
    // -------------------------------------------------------

      case '9000L':
        return _addCChannel9000LSeries(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // C CHANNEL - E-SERIES
    // -------------------------------------------------------

      case 'FRO_ES':
        return _addCChannelESeries(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // C CHANNEL - OP-139A
    // -------------------------------------------------------

      case 'FRO_OP139A':
        return _addCChannelOp139A(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // IN FLOOR TOW LINE - MIGHTY LUBE IN FLOOR TOW LINE
    // -------------------------------------------------------

      case 'IFT_IFTL':
        return _addInFloorTowLineMightyLube(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // IN FLOOR TOW LINE - OP-40E
    // Product ID: IFT_OP4OE
    // -------------------------------------------------------

      case 'IFT_OP4OE':
        return _addInFloorTowLineOp40e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // IN-BOARD ROLLER CHAIN
    // MIGHTY LUBE ROLLER FLIGHT CONVEYOR
    // Product ID: IBR_RFC
    // -------------------------------------------------------

      case 'IBR_RFC':
        return _addInBoardRollerChainMightyLubeRollerFlightConveyor(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // IN-BOARD ROLLER CHAIN
    // OP-40E
    // Product ID: IBR_OP4OE
    // -------------------------------------------------------

      case 'IBR_OP4OE':
        return _addInBoardRollerChainOp40e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // I-BEAM CONVEYOR BEAM SWEEP
    // Product ID: OH_CCS_IBEAM
    // -------------------------------------------------------

      case 'OH_CCS_IBEAM':
        return _addOverheadIBeamConveyorBeamSweep(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // OP-13 SANITARY HOOK CLEANER
    // Product ID: OH_CCS_OP13
    // -------------------------------------------------------

      case 'OH_CCS_OP13':
        return _addOverheadOp13SanitaryHookCleaner(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // OVERSPRAY ELIMINATOR BRUSH
    // Product ID: OH_CCS_BRUSH
    // -------------------------------------------------------

      case 'OH_CCS_BRUSH':
        return _addOverheadOversprayEliminatorBrush(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // NON-POWERED MIGHTY LUBE BRUSH CLEANERS 300I / 400I / 600I
    // Product ID: OH_CCS_3000
    // -------------------------------------------------------

      case 'OH_CCS_3000':
        return _addOverheadNonPoweredBrushCleaners300i400i600i(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // OP-8 POWER BRUSH CLEANING SYSTEM
    // CONVEYOR CHAIN & TROLLEY WHEEL CLEANER
    // Product ID: OH_CCS_OP8
    // -------------------------------------------------------

      case 'OH_CCS_OP8':
        return _addOverheadOp8PowerBrushCleaningSystem(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // OP-8NP NON-POWER BRUSH CLEANING SYSTEM
    // I-BEAM CONVEYOR CHAIN CLEANER
    // Product ID: OH_CCS_OP8NP
    // -------------------------------------------------------

      case 'OH_CCS_OP8NP':
        return _addOverheadOp8npNonPowerBrushCleaningSystem(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // OP-55
    // Product ID: OH_CCS_O55
    // -------------------------------------------------------

      case 'OH_CCS_O55':
        return _addOverheadOp55(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // YOKE CLEANING BRUSH
    // Product ID: OH_CCS_CLEANING_BRUSH
    // -------------------------------------------------------

      case 'OH_CCS_CLEANING_BRUSH':
        return _addOverheadYokeCleaningBrush(
          configuration: configuration,
          quantity: quantity,
        );


    // -------------------------------------------------------
    // GREASER POWER CHAIN
    // Product ID: OHP_GPC
    // -------------------------------------------------------

      case 'OHP_GPC':
        return _addOverheadGreaserPowerChain(
          configuration: configuration,
          quantity: quantity,
        );


    // ---------------------------------------------------------
    // 2100L SERIES SELF-CONTAINED I-BEAM CONVEYOR LUBRICATORS
    // Product ID: OHP_2100I
    // POST /api/ohp_2100i
    // ---------------------------------------------------------

      case 'OHP_2100I':
        return _addOverhead2100LSelfContainedIBeamConveyorLubricators(
          configuration: configuration,
          quantity: quantity,
        );


    // ---------------------------------------------------------
    // 9000L SERIES CENTRAL SYSTEM I-BEAM CONVEYOR LUBRICATORS
    // Product ID: OHP_9000I
    // POST /api/ohp_9000i
    // ---------------------------------------------------------

      case 'OHP_9000I':
        return _addOverhead9000LCentralSystemIBeamConveyorLubricators(
          configuration: configuration,
          quantity: quantity,
        );


      case 'OHP_CDL':
        return _addOverhead9125_9126CaterpillarDrive(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_ES':
        return _addOverheadESeries(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_OP4A':
        return _addOverheadOp4A(
          configuration: configuration,
          quantity: quantity,
        );


      case 'OHP_OP52':
        return _addOverheadOp52(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_OP139A':
        return _addOverheadOp139A(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_MLP':
        return _addOverheadMlp(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_PML':
        return _addOverheadPml(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_001':
        return _addOverhead001(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_PMM':
        return _addOverheadPmm(
          configuration: configuration,
          quantity: quantity,
        );
    // -------------------------------------------------------
    // UNKNOWN PRODUCT
    // -------------------------------------------------------

      default:
        return Future.value(
          ApiResponse<Map<String, dynamic>>.failure(
            message: 'Unsupported product: $productId',
          ),
        );
    }
  }



  // =========================================================
  // CC5 CHAIN LUBRICATOR
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCC5ChainLubricator({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'CC5_CLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cc5ChainLubricator,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // CC5 OP-40E
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addCC5Op40e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'CC5_OP4OEData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cc5Op40e,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // CATERPILLAR DRIVE LUBRICATORS
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCaterpillarDriveLubricators({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'COE_CDLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.caterpillarDriveLubricators,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // MIGHTY LUBE CHAIN ON EDGE LUBRICATOR
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addMightyLubeChainOnEdgeLubricator({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'COE_CELData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.mightyLubeChainOnEdgeLubricator,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // CATERPILLAR DRIVE OP-40E
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addCaterpillarOp40e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'COE_OP4OEData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.caterpillarOp40e,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETIPO UN91 / RW91
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtipoUn91({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETI_91Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etipoUn91,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETIPO 8074-B / 8075-B
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtipo8074({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETI_807Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etipo8074,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETIPO 9000INVL
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtipo9000Invl({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETI_9000INVLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etipo9000Invl,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETIPO OP-48E
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtipoOp48e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETI_OP48EData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etipoOp48e,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETOPO 2100L SERIES SELF-CONTAINED CONVEYOR LUBRICATORS
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtopo2100L({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETO_2100Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etopo2100L,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETOPO 9000L SERIES
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtopo9000L({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETO_9000EData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etopo9000L,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETOPO OP-48E
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtopoOp48e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETO_OP48EData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etopoOp48e,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETOPO PORTABLE MULTI-LINE MONITORING SYSTEM
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtopoPmlms({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETO_PMLMSData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etopoPmlms,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETOPO MULTI LINE ALL IN ONE
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtopoMlaio({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETO_MLAIOData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etopoMlaio,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // FREE CARRIER - FREE RAIL 314 "LOAD" WHEEL GREASER
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addFreeCarrier314({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FC_314Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.freeCarrier314,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // FREE CARRIER - FREE RAIL 317 "GUIDE" WHEEL GREASER
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addFreeCarrier317({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FC_317Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.freeCarrier317,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // FLAT TOP - OPCO 300 SERIES AUTOMATIC SEALED WHEEL
  // LUBRICATOR
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addFlatTopOpco300({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FT_OPCOData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.flatTopOpco300,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // FLAT TOP - MIGHTY LUBE FLAT TOP LUBRICATOR
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addFlatTopMightyLubeLubricator({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FT_MLCELData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.flatTopMightyLubeLubricator,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // FLAT TOP - OP-40E
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addFlatTopOp40e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FT_OP40EData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.flatTopOp40e,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // OVERSPRAY ELIMINATOR BRUSH
  // Product ID: FRO_OEB
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCChannelOversprayEliminatorBrush({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_OEBData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannelOversprayEliminatorBrush,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // FREE RAIL 314 "LOAD" WHEEL GREASER
  // Product ID: FRO_314
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCChannelFreeRail314({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_314Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannelFreeRail314,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // FREE RAIL 317 "GUIDE" WHEEL GREASER
  // Product ID: FRO_317
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCChannelFreeRail317({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_317Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannelFreeRail317,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // 9000L SERIES CENTRAL SYSTEM FREE CARRIER
  // CONVEYOR LUBRICATORS
  //
  // Product ID: 9000L
  // Backend Model/Route: FRO_9000F
  // POST /api/fro_9000f
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCChannel9000LSeries({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_9000FData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannel9000LSeries,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // E-SERIES
  //
  // Product ID: FRO_ES
  // POST /api/fro_es
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addCChannelESeries({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_ESData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannelESeries,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // OP-139A
  //
  // Product ID: FRO_OP139A
  // POST /api/fro_op139a
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addCChannelOp139A({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_OP139AData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannelOp139A,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // IN FLOOR TOW LINE
  // MIGHTY LUBE IN FLOOR TOW LINE
  //
  // Product ID: IFT_IFTL
  // Request Body: IFT_IFTLData
  // POST /api/ift_iftl
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addInFloorTowLineMightyLube({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'IFT_IFTLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.inFloorTowLineMightyLube,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // IN FLOOR TOW LINE
  // OP-40E
  //
  // Product ID: IFT_OP4OE
  // Request Body: IFT_OP4OEData
  // POST /api/ift_op4oe
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addInFloorTowLineOp40e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'IFT_OP4OEData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.inFloorTowLineOp40e,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // IN-BOARD ROLLER CHAIN
  // MIGHTY LUBE ROLLER FLIGHT CONVEYOR
  //
  // Product ID: IBR_RFC
  // Request Body: IBR_RFCData
  // POST /api/ibr_rfc
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addInBoardRollerChainMightyLubeRollerFlightConveyor({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'IBR_RFCData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.inBoardRollerChainMightyLubeRollerFlightConveyor,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // IN-BOARD ROLLER CHAIN
  // OP-40E
  //
  // Product ID: IBR_OP4OE
  // Request Body: IBR_OP4OEData
  // POST /api/ibr_op4oe
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addInBoardRollerChainOp40e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'IBR_OP4OEData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.inBoardRollerChainOp40e,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // I-BEAM CONVEYOR BEAM SWEEP
  //
  // Product ID: OH_CCS_IBEAM
  // Request Body: OH_CCS_IBEAMData
  // POST /api/oh_ccs_ibeam
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadIBeamConveyorBeamSweep({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_IBEAMData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadIBeamConveyorBeamSweep,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // OP-13 SANITARY HOOK CLEANER
  //
  // Product ID: OH_CCS_OP13
  // Request Body: OH_CCS_OP13Data
  // POST /api/oh_ccs_op13
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadOp13SanitaryHookCleaner({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_OP13Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp13SanitaryHookCleaner,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // OVERSPRAY ELIMINATOR BRUSH
  //
  // Product ID: OH_CCS_BRUSH
  // Request Body: OH_CCS_BRUSHData
  // POST /api/oh_ccs_brush
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadOversprayEliminatorBrush({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_BRUSHData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOversprayEliminatorBrush,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // NON-POWERED MIGHTY LUBE BRUSH CLEANERS 300I / 400I / 600I
  //
  // Product ID: OH_CCS_3000
  // Request Body: OH_CCS_3000Data
  // POST /api/oh_ccs_3000
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadNonPoweredBrushCleaners300i400i600i({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_3000Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadNonPoweredBrushCleaners300i400i600i,
      body: body,
      parser: _mapParser,
    );
  }


  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // OP-8 POWER BRUSH CLEANING SYSTEM
  // CONVEYOR CHAIN & TROLLEY WHEEL CLEANER
  //
  // Product ID: OH_CCS_OP8
  // Request Body: OH_CCS_OP8Data
  // POST /api/oh_ccs_op8
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadOp8PowerBrushCleaningSystem({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_OP8Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp8PowerBrushCleaningSystem,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // OP-8NP NON-POWER BRUSH CLEANING SYSTEM
  // I-BEAM CONVEYOR CHAIN CLEANER
  //
  // Product ID: OH_CCS_OP8NP
  // Request Body: OH_CCS_OP8NPData
  // POST /api/oh_ccs_op8np
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadOp8npNonPowerBrushCleaningSystem({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_OP8NPData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp8npNonPowerBrushCleaningSystem,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // OP-55
  //
  // Product ID: OH_CCS_O55
  // Request Body: OH_CCS_O55Data
  // POST /api/oh_ccs_o55
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadOp55({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_O55Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp55,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // YOKE CLEANING BRUSH
  //
  // Product ID: OH_CCS_CLEANING_BRUSH
  // Request Body: OH_CCS_CLEANING_BRUSHData
  // POST /api/oh_ccs_cleaning_brush
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadYokeCleaningBrush({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_CLEANING_BRUSHData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadYokeCleaningBrush,
      body: body,
      parser: _mapParser,
    );
  }


  // =========================================================
  // GREASER POWER CHAIN
  //
  // Product ID: OHP_GPC
  // Request Body: OHP_GPCData
  // POST /api/ohp_gpc
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadGreaserPowerChain({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_GPCData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadGreaserPowerChain,
      body: body,
      parser: _mapParser,
    );
  }

  // ---------------------------------------------------------
// 2100L SERIES SELF-CONTAINED I-BEAM CONVEYOR LUBRICATORS
// Product ID: OHP_2100I
// Request Body: OHP_2100IData
// POST /api/ohp_2100i
// ---------------------------------------------------------

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverhead2100LSelfContainedIBeamConveyorLubricators({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_2100IData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overhead2100LSelfContainedIBeamConveyorLubricators,
      body: body,
      parser: _mapParser,
    );
  }

  // ---------------------------------------------------------
// 9000L SERIES CENTRAL SYSTEM I-BEAM CONVEYOR LUBRICATORS
// Product ID: OHP_9000I
// Request Body: OHP_9000IData
// POST /api/ohp_9000i
// ---------------------------------------------------------

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverhead9000LCentralSystemIBeamConveyorLubricators({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_9000IData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overhead9000LCentralSystemIBeamConveyorLubricators,
      body: body,
      parser: _mapParser,
    );
  }


  // ---------------------------------------------------------
// 9125/9126 CATERPILLAR DRIVE
// Product ID: OHP_CDL
// Request Body: OHP_CDLData
// POST /api/ohp_cdl
// ---------------------------------------------------------

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverhead9125_9126CaterpillarDrive({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_CDLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overhead9125_9126CaterpillarDrive,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadESeries({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_ESData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadESeries,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadOp4A({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_OP4AData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp4A,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadOp52({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_OP52Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp52,
      body: body,
      parser: _mapParser,
    );
  }

  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadOp139A({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_OP139AData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp139A,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadMlp({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_MLPData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadMlp,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadPml({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_PMLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadPml,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverhead001({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_001Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overhead001,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadPmm({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_PMMData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadPmm,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // GET CONFIGURATOR / CART
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getOrders() {
    return ApiClient.get<List<dynamic>>(
      url: ApiEndpoints.cart,
      parser: (data) {
        if (data is List) {
          return List<dynamic>.from(data);
        }

        return <dynamic>[];
      },
    );
  }

  // =========================================================
  // GET USER ORDERS
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getUserOrders() {
    return ApiClient.get<List<dynamic>>(
      url: ApiEndpoints.userOrders,
      parser: (data) {
        if (data is List) {
          return List<dynamic>.from(data);
        }

        return <dynamic>[];
      },
    );
  }

  // =========================================================
  // GET CONFIGURATIONS
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getConfigurations() {
    return ApiClient.get<List<dynamic>>(
      url: ApiEndpoints.configurations,
      parser: (data) {
        if (data is List) {
          return List<dynamic>.from(data);
        }

        return <dynamic>[];
      },
    );
  }

  // =========================================================
  // COMMON MAP PARSER
  // =========================================================

  static Map<String, dynamic> _mapParser(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return <String, dynamic>{};
  }
}