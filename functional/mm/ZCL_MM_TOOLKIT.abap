CLASS zcl_mm_toolkit DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      tt_hiy TYPE STANDARD TABLE OF zmms_hiy .
    TYPES t_werks_lgort TYPE zsdt_werks_lgort .
    TYPES:
      tt_werks_lgort TYPE STANDARD TABLE OF t_werks_lgort .
    TYPES:
      BEGIN OF t_prdha_kostl,
        werks TYPE werks_d,
        prdha TYPE prodh_d,
        kostl TYPE kostl,
      END OF t_prdha_kostl .
    TYPES:
      tt_prdha_kostl TYPE HASHED TABLE OF t_prdha_kostl WITH UNIQUE KEY primary_key COMPONENTS werks prdha .
    TYPES:
      BEGIN OF ty_txt_material,
        matnr TYPE matnr,
        maktx TYPE maktx,
      END OF ty_txt_material .
    TYPES:
      BEGIN OF t_karak_malzeme,
        matnr       TYPE matnr,
        zbslkkunag  TYPE kunag,
        zklmurtmtur TYPE zsdd_zklmurtmtur,
        zklmkat     TYPE zsdd_kat,
        zklmgrm2    TYPE atwrt,
        zklmgrm2_d  TYPE zsdd_grm2,
        zklmrenk    TYPE zrenk,
        zklmhrmn    TYPE zsdd_hrmn,
        zklmhcmyum  TYPE zsdd_hcmyum,
        zklmozlkrk  TYPE zsdd_ozlkrk,
      END OF t_karak_malzeme .
    TYPES:
      BEGIN OF t_karak_parti,
        matnr              TYPE matnr,
        charg              TYPE charg_d,
        gr_m2              TYPE zsdd_gr_m2_char,
        kat_adedi          TYPE zsdd_kat_adedi_char,
        mihver_boru_capi   TYPE zsdd_mihver_boru_capi_char,
        bobin_capi         TYPE zsdd_bobin_capi_char,
        bobin_genisligi    TYPE zsdd_bobin_genisligi_char,
        grup_no            TYPE zsdd_grup_no_char,
        gr_m2_d            TYPE zsdd_gr_m2,
        kat_adedi_d        TYPE zsdd_kat_adedi,
        mihver_boru_capi_d TYPE  zsdd_mihver_boru_capi,
        bobin_capi_d       TYPE zsdd_bobin_capi,
        bobin_genisligi_d  TYPE zsdd_bobin_genisligi,
        zkagit_makine      TYPE zsdd_arbpl,
        lobm_hsdat         TYPE hsdat,
      END OF t_karak_parti .
    TYPES:
      tt_karak_parti TYPE HASHED TABLE OF t_karak_parti WITH UNIQUE KEY primary_key COMPONENTS matnr charg .
    TYPES:
      tt_karak_malzeme TYPE HASHED TABLE OF t_karak_malzeme WITH UNIQUE KEY primary_key COMPONENTS matnr .

    CONSTANTS c_atnam_zgr_m2 TYPE atnam VALUE 'ZGR_M2' ##NO_TEXT.
    CONSTANTS c_atnam_zkagit_makine TYPE atnam VALUE 'ZKAGIT_MAKINE' ##NO_TEXT.
    CONSTANTS c_atnam_zkat_adedi TYPE atnam VALUE 'ZKAT_ADEDI' ##NO_TEXT.
    CONSTANTS c_atnam_zmihver_boru_capi TYPE atnam VALUE 'ZMIHVER_BORU_CAPI' ##NO_TEXT.
    CONSTANTS c_atnam_zbobin_capi TYPE atnam VALUE 'ZBOBIN_CAPI' ##NO_TEXT.
    CONSTANTS c_atnam_zbobin_genisligi TYPE atnam VALUE 'ZBOBIN_GENISLIGI' ##NO_TEXT.
    CONSTANTS c_atnam_lobm_hsdat TYPE atnam VALUE 'LOBM_HSDAT' ##NO_TEXT.
    CONSTANTS c_atnam_grup_no TYPE atnam VALUE 'ZGRUP' ##NO_TEXT.
    CONSTANTS c_atnam_zbslkkunag TYPE atnam VALUE 'ZBSLKKUNAG' ##NO_TEXT.
    CONSTANTS c_atnam_zklmurtmtur TYPE atnam VALUE 'ZKLMURTMTUR' ##NO_TEXT.
    CONSTANTS c_atnam_zklmkat TYPE atnam VALUE 'ZKLMKAT' ##NO_TEXT.
    CONSTANTS c_atnam_zklmgrm2 TYPE atnam VALUE 'ZKLMGRM2' ##NO_TEXT.
    CONSTANTS c_atnam_zklmrenk TYPE atnam VALUE 'ZKLMRENK' ##NO_TEXT.
    CONSTANTS c_atnam_zklmhrmn TYPE atnam VALUE 'ZKLMHRMN' ##NO_TEXT.
    CONSTANTS c_atnam_zklmhcmyum TYPE atnam VALUE 'ZKLMHCMYUM' ##NO_TEXT.
    CONSTANTS c_atnam_zklmozlkrk TYPE atnam VALUE 'ZKLMOZLKRK' ##NO_TEXT.
    CLASS-DATA gs_return TYPE bapiret2 .
    CLASS-DATA gt_werks_lgort TYPE tt_werks_lgort .

    CLASS-METHODS check_material_existence
      IMPORTING
        !iv_matnr TYPE matnr
      RAISING
        zcx_mm_material .
    CLASS-METHODS goodsmvt_getdetail
      IMPORTING
        VALUE(iv_docnumb) TYPE mblnr
        VALUE(iv_docyear) TYPE mjahr
      EXPORTING
        !es_header        TYPE zmms_gm_head
        !et_items         TYPE zmmtt_gm_item
        !et_return        TYPE bapiret2_t
      EXCEPTIONS
        doc_not_found .
    CLASS-METHODS get_charg_werks_lgort
      RETURNING
        VALUE(rv_charg) TYPE zsdt_werks_lgort-charg .
    CLASS-METHODS get_karak_malzeme
      IMPORTING
        !iv_matnr     TYPE matnr
      RETURNING
        VALUE(rs_ret) TYPE t_karak_malzeme .
    CLASS-METHODS get_karak_parti
      IMPORTING
        !iv_matnr     TYPE matnr
        !iv_charg     TYPE charg_d
      RETURNING
        VALUE(rs_ret) TYPE t_karak_parti .
    CLASS-METHODS get_mmbe_sas_stock
      IMPORTING
        !iv_matnr       TYPE matnr
        !iv_werks       TYPE werks_d
        !iv_lgort       TYPE lgort_d OPTIONAL
      RETURNING
        VALUE(rv_menge) TYPE menge_d .
    CLASS-METHODS get_hiy
      CHANGING
        !ct_data TYPE ANY TABLE .
    CLASS-METHODS is_creating_material
      IMPORTING
        !iv_tcode     TYPE sytcode DEFAULT sy-tcode
      RETURNING
        VALUE(rv_yes) TYPE abap_bool .
    CLASS-METHODS is_displaying_material
      IMPORTING
        !iv_tcode     TYPE sytcode DEFAULT sy-tcode
      RETURNING
        VALUE(rv_yes) TYPE abap_bool .
    CLASS-METHODS is_modifying_material
      IMPORTING
        !iv_tcode     TYPE sytcode DEFAULT sy-tcode
      RETURNING
        VALUE(rv_yes) TYPE abap_bool .
    CLASS-METHODS is_updating_material
      IMPORTING
        !iv_tcode     TYPE sytcode DEFAULT sy-tcode
      RETURNING
        VALUE(rv_yes) TYPE abap_bool .
    CLASS-METHODS get_karak_text
      IMPORTING
        !iv_matnr       TYPE matnr
        !iv_charg       TYPE charg_d
      RETURNING
        VALUE(rt_lines) TYPE tline_tab .
    CLASS-METHODS save_karak_text
      IMPORTING
        !iv_matnr TYPE matnr
        !iv_charg TYPE charg_d
        !it_lines TYPE tline_tab .

    CLASS-METHODS get_material_class_data
      IMPORTING
        !iv_matnr                    TYPE matnr
        !iv_classnum                 TYPE bapi1003_key-classnum
        VALUE(iv_classtype)          TYPE bapi1003_key-classtype DEFAULT '001'
        VALUE(iv_keydate)            TYPE sy-datum OPTIONAL
        VALUE(iv_unvaluated_chars)   TYPE flag DEFAULT 'X'
        !iv_check_material_existence TYPE abap_bool DEFAULT abap_true
        !iv_check_class_existence    TYPE abap_bool DEFAULT abap_true
      EXPORTING
        !et_num                      TYPE tt_bapi1003_alloc_values_num
        !et_char                     TYPE tt_bapi1003_alloc_values_char
        !et_curr                     TYPE tt_bapi1003_alloc_values_curr
        !et_return                   TYPE bapiret2_t
      RAISING
        zcx_mm_material .

  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS c_langu TYPE thead-tdspras VALUE 'T' ##NO_TEXT.
    CONSTANTS c_table_mara TYPE bapi1003_key-objecttable VALUE 'MARA' ##NO_TEXT.
    CONSTANTS c_tdid TYPE thead-tdid VALUE 'VERM' ##NO_TEXT.
    CONSTANTS c_tdobject TYPE thead-tdobject VALUE 'CHARGE' ##NO_TEXT.
    CLASS-DATA gt_karak_parti_multiton TYPE tt_karak_parti .
    CLASS-DATA gt_karak_malzeme_multiton TYPE tt_karak_malzeme .
    CONSTANTS c_tcode_create_mat TYPE sytcode VALUE 'MM01' ##NO_TEXT.
    CONSTANTS c_tcode_display_mat TYPE sytcode VALUE 'MM03' ##NO_TEXT.
    CONSTANTS c_tcode_edit_mat TYPE sytcode VALUE 'MM02' ##NO_TEXT.
ENDCLASS.



CLASS zcl_mm_toolkit IMPLEMENTATION.


  METHOD check_material_existence.

    SELECT SINGLE mandt INTO sy-mandt ##write_ok
           FROM mara
           WHERE matnr EQ iv_matnr.

    CHECK sy-subrc NE 0.

    RAISE EXCEPTION TYPE zcx_mm_material
      EXPORTING
        matnr  = iv_matnr
        textid = zcx_mm_material=>undefined.

  ENDMETHOD.


  METHOD get_charg_werks_lgort.
*   Elit 24 e özel bir geliştirme başka bir yerde kullanılmasın bulunan ilk kaydı alıyor.
    IF gt_werks_lgort IS INITIAL.
      SELECT * UP TO 1 ROWS FROM zsdt_werks_lgort INTO TABLE gt_werks_lgort.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO gt_werks_lgort.
      ENDIF.
    ENDIF.
    ASSIGN gt_werks_lgort[ 1 ] TO FIELD-SYMBOL(<ls_werks_lgort>).
    IF sy-subrc = 0.
      rv_charg = <ls_werks_lgort>-charg.
    ENDIF.
  ENDMETHOD.


  METHOD get_hiy.

    DATA : lt_hiy   TYPE STANDARD TABLE OF prodh_disp,
           lv_comp  TYPE char50,
           ls_datax TYPE zmms_hiy,
           lt_datax TYPE SORTED TABLE OF zmms_hiy
                    WITH UNIQUE KEY prdha.

    LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<ls_data>).

      ASSIGN COMPONENT 'PRDHA' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_data_prdha>).
      CHECK sy-subrc EQ 0.
      CHECK <lv_data_prdha> IS NOT INITIAL.

      READ TABLE lt_datax INTO ls_datax WITH TABLE KEY prdha = <lv_data_prdha>.
      IF sy-subrc EQ 0.
        MOVE-CORRESPONDING ls_datax TO <ls_data>.
      ELSE.
        CLEAR : lt_hiy,ls_datax.
        CALL FUNCTION 'RV_PRODUKTHIERARCHIE_PRED_GET'
          EXPORTING
            spras               = sy-langu
            node                = <lv_data_prdha>
          TABLES
            disp_t179           = lt_hiy
          EXCEPTIONS
            node_does_not_exist = 1.
        IF sy-subrc EQ 0.
          CLEAR ls_datax.
          MOVE-CORRESPONDING <ls_data> TO ls_datax.
          LOOP AT lt_hiy ASSIGNING FIELD-SYMBOL(<ls_hiy>).
            lv_comp = |PRODH{ <ls_hiy>-stufe }|.
            ASSIGN COMPONENT lv_comp OF STRUCTURE ls_datax TO FIELD-SYMBOL(<lv_prodh>).
            IF sy-subrc EQ 0.
              <lv_prodh> = <ls_hiy>-prodh.
            ENDIF.
            lv_comp = |VTEXT{ <ls_hiy>-stufe }|.
            ASSIGN COMPONENT lv_comp OF STRUCTURE ls_datax TO FIELD-SYMBOL(<lv_vtext>).
            IF sy-subrc EQ 0.
              <lv_vtext> = <ls_hiy>-vtext.
            ENDIF.
          ENDLOOP.
          MOVE-CORRESPONDING ls_datax TO <ls_data>.
          INSERT ls_datax INTO TABLE lt_datax.
        ENDIF.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.


  METHOD get_karak_malzeme.

    DATA: lt_allocvaluesnum         TYPE TABLE OF  bapi1003_alloc_values_num,
          lt_allocvaluesnum_sorted  TYPE SORTED TABLE OF  bapi1003_alloc_values_num WITH UNIQUE KEY charact,
          lt_allocvalueschar_sorted TYPE SORTED TABLE OF  bapi1003_alloc_values_char WITH UNIQUE KEY charact,
          lt_allocvalueschar        TYPE TABLE OF  bapi1003_alloc_values_char,
          lt_allocvaluescurr        TYPE TABLE OF  bapi1003_alloc_values_curr,
          lt_return                 TYPE TABLE OF bapiret2,
          lv_objectkey              TYPE bapi1003_key-object.

    FIELD-SYMBOLS : <lv_value>  TYPE atflv.
    FIELD-SYMBOLS : <lv_value_c>  TYPE atwrt.

    CHECK iv_matnr IS NOT INITIAL.
    ASSIGN gt_karak_malzeme_multiton[ KEY primary_key COMPONENTS matnr = iv_matnr  ] TO FIELD-SYMBOL(<ls_kpm>).

    IF sy-subrc NE 0.

      DATA(ls_kpm) = VALUE t_karak_malzeme( matnr = iv_matnr ).

      lv_objectkey = ls_kpm-matnr.

      CLEAR  : lt_allocvaluesnum ,
               lt_allocvalueschar,
               lt_allocvaluescurr.

      CALL FUNCTION 'BAPI_OBJCL_GETDETAIL'
        EXPORTING
          objectkey       = lv_objectkey
          objecttable     = 'MARA'
          classnum        = 'Z_YARI_URUN'
          classtype       = '300'
        TABLES
          allocvaluesnum  = lt_allocvaluesnum
          allocvalueschar = lt_allocvalueschar
          allocvaluescurr = lt_allocvaluescurr
          return          = lt_return.

      SORT lt_allocvaluesnum BY charact.
      SORT lt_allocvalueschar BY charact.
      lt_allocvaluesnum_sorted  = lt_allocvaluesnum.
      lt_allocvalueschar_sorted = lt_allocvalueschar.

      ASSIGN lt_allocvalueschar_sorted[ charact = c_atnam_zbslkkunag ]-value_char TO <lv_value_c>.
      IF sy-subrc EQ 0.
        ls_kpm-zbslkkunag = <lv_value_c>.
      ENDIF.

      ASSIGN lt_allocvalueschar_sorted[ charact = c_atnam_zklmurtmtur ]-value_char TO <lv_value_c>.
      IF sy-subrc EQ 0.
        ls_kpm-zklmurtmtur = <lv_value_c>.
      ENDIF.

      ASSIGN lt_allocvaluesnum_sorted[ charact = c_atnam_zklmkat ]-value_from TO <lv_value>.
      IF sy-subrc EQ 0.
        ls_kpm-zklmkat = <lv_value>.
      ENDIF.

      ASSIGN lt_allocvaluesnum_sorted[ charact = c_atnam_zklmgrm2 ]-value_from TO <lv_value>.
      IF sy-subrc EQ 0.
        ls_kpm-zklmgrm2_d = <lv_value>.
        ls_kpm-zklmgrm2   = zcl_bc_ddic_toolkit=>float_to_char( <lv_value> ).
      ENDIF.

      ASSIGN lt_allocvalueschar_sorted[ charact = c_atnam_zklmrenk ]-value_char TO <lv_value_c>.
      IF sy-subrc EQ 0.
        ls_kpm-zklmrenk = <lv_value_c>.
      ENDIF.

      ASSIGN lt_allocvalueschar_sorted[ charact = c_atnam_zklmhrmn ]-value_char TO <lv_value_c>.
      IF sy-subrc EQ 0.
        ls_kpm-zklmhrmn = <lv_value_c>.
      ENDIF.

      ASSIGN lt_allocvalueschar_sorted[ charact = c_atnam_zklmhcmyum ]-value_char TO <lv_value_c>.
      IF sy-subrc EQ 0.
        ls_kpm-zklmhcmyum = <lv_value_c>.
      ENDIF.

      ASSIGN lt_allocvalueschar_sorted[ charact = c_atnam_zklmozlkrk ]-value_char TO  <lv_value_c>.
      IF sy-subrc EQ 0.
        ls_kpm-zklmozlkrk = <lv_value_c>.
      ENDIF.

      INSERT ls_kpm INTO TABLE gt_karak_malzeme_multiton ASSIGNING <ls_kpm>.

    ENDIF.

    rs_ret = <ls_kpm>.

  ENDMETHOD.


  METHOD get_karak_parti.

    DATA: lt_allocvaluesnum         TYPE TABLE OF  bapi1003_alloc_values_num,
          lt_allocvaluesnum_sorted  TYPE SORTED TABLE OF  bapi1003_alloc_values_num WITH UNIQUE KEY charact,
          lt_allocvalueschar_sorted TYPE SORTED TABLE OF  bapi1003_alloc_values_char WITH UNIQUE KEY charact,
          lt_allocvalueschar        TYPE TABLE OF  bapi1003_alloc_values_char,
          lt_allocvaluescurr        TYPE TABLE OF  bapi1003_alloc_values_curr,
          lt_return                 TYPE TABLE OF bapiret2,
          lv_objectkey              TYPE bapi1003_key-object,
          lv_hsdat                  TYPE cawn-atwrt.

    FIELD-SYMBOLS : <lv_value>  TYPE atflv.

    "--------->> add by mehmet sertkaya 27.01.2017 09:54:33
    CHECK iv_charg IS NOT INITIAL.
    "-----------------------------<<
    ASSIGN gt_karak_parti_multiton[ KEY primary_key COMPONENTS matnr = iv_matnr
                                                               charg = iv_charg ] TO FIELD-SYMBOL(<ls_kpm>).

    IF sy-subrc NE 0.

      DATA(ls_kpm) = VALUE t_karak_parti( matnr = iv_matnr
                                          charg = iv_charg ).

      lv_objectkey = |{ ls_kpm-matnr }{ ls_kpm-charg }|.

      CLEAR  : lt_allocvaluesnum ,
               lt_allocvalueschar,
               lt_allocvaluescurr.

      CALL FUNCTION 'BAPI_OBJCL_GETDETAIL'
        EXPORTING
          objectkey       = lv_objectkey
          objecttable     = 'MCH1'
          classnum        = 'Z_YARI_URUN'
          classtype       = '023'
        TABLES
          allocvaluesnum  = lt_allocvaluesnum
          allocvalueschar = lt_allocvalueschar
          allocvaluescurr = lt_allocvaluescurr
          return          = lt_return.

      SORT lt_allocvaluesnum BY charact.
      SORT lt_allocvalueschar BY charact.

      lt_allocvaluesnum_sorted  = lt_allocvaluesnum.
      lt_allocvalueschar_sorted = lt_allocvalueschar.

      ASSIGN lt_allocvaluesnum_sorted[ charact = c_atnam_zgr_m2 ]-value_from TO <lv_value>.
      IF sy-subrc EQ 0.
        ls_kpm-gr_m2_d = <lv_value>.
        ls_kpm-gr_m2 = zcl_bc_ddic_toolkit=>float_to_char( <lv_value> ).
      ENDIF.

      ASSIGN lt_allocvaluesnum_sorted[ charact = c_atnam_zkat_adedi ]-value_from TO  <lv_value>.
      IF sy-subrc EQ 0.
        ls_kpm-kat_adedi_d = <lv_value>.
        ls_kpm-kat_adedi = zcl_bc_ddic_toolkit=>float_to_char( <lv_value> ).
      ENDIF.

      ASSIGN lt_allocvaluesnum_sorted[ charact = c_atnam_zmihver_boru_capi ]-value_from TO  <lv_value>.
      IF sy-subrc EQ 0.
        ls_kpm-mihver_boru_capi_d = <lv_value>.
        ls_kpm-mihver_boru_capi = zcl_bc_ddic_toolkit=>float_to_char( <lv_value> ).
      ENDIF.

      ASSIGN lt_allocvaluesnum_sorted[ charact = c_atnam_zbobin_capi ]-value_from TO  <lv_value>.
      IF sy-subrc EQ 0.
        ls_kpm-bobin_capi_d = <lv_value>.
        ls_kpm-bobin_capi = zcl_bc_ddic_toolkit=>float_to_char( <lv_value> ).
      ENDIF.

      ASSIGN lt_allocvaluesnum_sorted[ charact = c_atnam_zbobin_genisligi ]-value_from TO  <lv_value>.
      IF sy-subrc EQ 0.
        ls_kpm-bobin_genisligi_d = <lv_value>.
        ls_kpm-bobin_genisligi = zcl_bc_ddic_toolkit=>float_to_char( <lv_value> ).
      ENDIF.

      ASSIGN lt_allocvaluesnum_sorted[ charact = c_atnam_lobm_hsdat ]-value_from TO  <lv_value>.
      IF sy-subrc EQ 0.
        CALL FUNCTION 'CTCV_CONVERT_FLOAT_TO_DATE'
          EXPORTING
            float = <lv_value>
          IMPORTING
            date  = lv_hsdat.
        ls_kpm-lobm_hsdat = lv_hsdat.
      ENDIF.



      ASSIGN lt_allocvalueschar_sorted[ charact = c_atnam_grup_no ]-value_char TO FIELD-SYMBOL(<lv_value_c>).
      IF sy-subrc EQ 0.
        ls_kpm-grup_no = <lv_value_c>.
      ENDIF.


      ASSIGN lt_allocvalueschar_sorted[ charact = c_atnam_zkagit_makine ]-value_char TO <lv_value_c>.
      IF sy-subrc EQ 0.
        ls_kpm-zkagit_makine = <lv_value_c>.
      ENDIF.

      INSERT ls_kpm INTO TABLE gt_karak_parti_multiton ASSIGNING <ls_kpm>.

    ENDIF.

    rs_ret = <ls_kpm>.

  ENDMETHOD.


  METHOD get_karak_text.

    DATA: lv_name TYPE thead-tdname.

    CHECK iv_charg IS NOT INITIAL AND iv_matnr IS NOT INITIAL.

    lv_name+0(18) = iv_matnr.
    lv_name+22(10) = iv_charg.

    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        id                      = c_tdid
        language                = c_langu
        name                    = lv_name
        object                  = c_tdobject
      TABLES
        lines                   = rt_lines
      EXCEPTIONS
        id                      = 1
        language                = 2
        name                    = 3
        not_found               = 4
        object                  = 5
        reference_check         = 6
        wrong_access_to_archive = 7
        OTHERS                  = 8.
    IF sy-subrc <> 0.
    ENDIF.


  ENDMETHOD.


  METHOD get_material_class_data.

    DATA: lt_alloclist TYPE STANDARD TABLE OF bapi1003_alloc_list WITH DEFAULT KEY,
          lt_return    TYPE STANDARD TABLE OF bapiret2 WITH DEFAULT KEY,
          lv_date      TYPE sy-datum,
          lv_objkey    TYPE bapi1003_key-object.

    " Hazırlık """"""""""""""""""""""""""""""""""""""""""""""""""""""

    CHECK iv_matnr IS NOT INITIAL AND
          iv_classnum IS NOT INITIAL.

    lv_objkey = iv_matnr.

    lv_date = sy-datum.
    IF iv_keydate IS NOT INITIAL.
      lv_date = iv_keydate.
    ENDIF.

    " Malzeme kontrolü """"""""""""""""""""""""""""""""""""""""""""""

    IF iv_check_material_existence EQ abap_true AND
       zcl_mm_material=>get_mara( iv_matnr )-meins IS INITIAL.
      RETURN.
    ENDIF.

    " Sınıf kontrolü """"""""""""""""""""""""""""""""""""""""""""""""

    IF iv_check_class_existence EQ abap_true.

      CALL FUNCTION 'BAPI_OBJCL_GETCLASSES'
        EXPORTING
          objectkey_imp   = lv_objkey
          objecttable_imp = c_table_mara
          classtype_imp   = iv_classtype
          read_valuations = abap_true
          keydate         = lv_date
          language        = sy-langu
        TABLES
          alloclist       = lt_alloclist
          return          = et_return.

    ENDIF.

    " Verilerin çekilmesi """""""""""""""""""""""""""""""""""""""""""

    CALL FUNCTION 'BAPI_OBJCL_GETDETAIL'
      EXPORTING
        objectkey        = lv_objkey
        objecttable      = c_table_mara
        classnum         = iv_classnum
        classtype        = iv_classtype
        keydate          = lv_date
        unvaluated_chars = abap_true
        language         = sy-langu
      TABLES
        allocvaluesnum   = et_num
        allocvalueschar  = et_char
        allocvaluescurr  = et_curr
        return           = et_return.

  ENDMETHOD.


  METHOD get_mmbe_sas_stock.

    DATA: BEGIN OF ls_xtab ,
            werks TYPE ekpo-werks,
            lgort TYPE ekpo-lgort,
            matnr TYPE ekpo-matnr,
            menge TYPE ekpo-menge,
            mengk TYPE ekpo-menge,
          END OF ls_xtab,
          lt_xtab  LIKE TABLE OF ls_xtab,
          lt_werks TYPE RANGE OF werks_d,
          lt_lgort TYPE RANGE OF lgort_d.

    CLEAR rv_menge.


    SELECT SINGLE meins INTO @DATA(lv_meins) FROM mara
       WHERE matnr EQ @iv_matnr.

    APPEND VALUE #( sign = 'I'
                    option = 'EQ'
                    low = iv_werks ) TO lt_werks.

    IF iv_lgort IS NOT INITIAL.

      APPEND VALUE #( sign = 'I'
                      option = 'EQ'
                      low = iv_lgort ) TO lt_lgort.
    ENDIF.

    CALL FUNCTION 'MB_ADD_PURCHASE_ORDER_QUANTITY'
      EXPORTING
        x_elikz = space
        x_loekz = space
        x_matnr = iv_matnr
        x_meins = lv_meins
      TABLES
        xtab    = lt_xtab
        xwerks  = lt_werks.

    LOOP AT lt_xtab INTO ls_xtab WHERE lgort IN lt_lgort.
      ADD ls_xtab-menge TO rv_menge.
    ENDLOOP.

  ENDMETHOD.


  METHOD goodsmvt_getdetail.

    DATA : ls_header       TYPE bapi2017_gm_head_02.
    DATA : lt_items        TYPE TABLE OF bapi2017_gm_item_show.
    DATA : lt_txt_material TYPE TABLE OF ty_txt_material,
           lt_txt_depo     TYPE TABLE OF ty_txt_depo.

    CALL FUNCTION 'BAPI_GOODSMVT_GETDETAIL'
      EXPORTING
        materialdocument = iv_docnumb
        matdocumentyear  = iv_docyear
      IMPORTING
        goodsmvt_header  = ls_header
      TABLES
        goodsmvt_items   = lt_items
        return           = et_return.

    LOOP AT et_return ASSIGNING FIELD-SYMBOL(<fs_return>)
      WHERE type CA 'AEX'.EXIT.
    ENDLOOP.

    IF sy-subrc = 0.
      RAISE doc_not_found.
    ENDIF.

*=====================================================*
*   Başlık Main alanlar / ES_HEADER
*=====================================================*
    es_header = CORRESPONDING #( ls_header ).


*=====================================================*
*   Başlık Ek Alanlar   / ES_HEADER
*=====================================================*
    READ TABLE lt_items ASSIGNING FIELD-SYMBOL(<fs_item>) INDEX 1.

*   Şirket kodu  /
*   Üretim yeri  /
*   Depo   no    /
*   Hareket türü /
    SELECT SINGLE  bukrs                   ##WARN_OK
                   werks
                   lgnum
                   bwart FROM mseg
             INTO (es_header-bukrs,
                   es_header-werks,
                   es_header-lgnum,
                   es_header-bwart)
            WHERE  mblnr = iv_docnumb
              AND  mjahr = iv_docyear.

*   Şirket kodu tanım
    SELECT SINGLE  butxt FROM t001
             INTO  es_header-butxt
            WHERE  bukrs = es_header-bukrs.

*   Üretim yeri tanımı
    SELECT SINGLE  name1 FROM t001w
             INTO  es_header-werksxt
            WHERE  werks = es_header-werks.

*   SA Grubu / Satıcı
    SELECT SINGLE  ekgrp lifnr FROM ekko
             INTO  (es_header-ekgrp,es_header-lifnr)
            WHERE  ebeln = <fs_item>-po_number.

*   Satıcı tanım
    SELECT SINGLE  name1 FROM lfa1
             INTO  es_header-lifnrxt
            WHERE  lifnr = es_header-lifnr.

*   Telefon
    SELECT SINGLE  tel_number FROM t024
             INTO  es_header-tel_number
            WHERE  ekgrp = es_header-ekgrp.

*   PO Number
    es_header-po_number = <fs_item>-po_number.


*=====================================================*
*   Kalem Main Alanlar / ET_ITEMS
*=====================================================*
    et_items = CORRESPONDING #( lt_items ).


*=====================================================*
*   Kalem Ek Alanlar   / ET_ITEMS
*=====================================================*
    IF et_items IS NOT INITIAL.

*     Malzeme metin
      SELECT matnr
             maktx
        FROM makt INTO TABLE lt_txt_material
        FOR ALL ENTRIES IN et_items
        WHERE matnr = et_items-material
          AND spras = sy-langu.

*     Depo yeri tanım
      SELECT werks
             lgort
             lgobe
        FROM t001l INTO TABLE lt_txt_depo
        FOR ALL ENTRIES IN et_items
        WHERE werks = et_items-plant
          AND lgort = et_items-stge_loc.

    ENDIF.

    LOOP AT et_items ASSIGNING FIELD-SYMBOL(<fs_items>).

      TRY.
          <fs_items>-maktx = lt_txt_material[ matnr = <fs_items>-material ]-maktx.
        CATCH cx_sy_itab_line_not_found.

          SELECT SINGLE txz01 INTO <fs_items>-maktx
                 FROM ekpo
                 WHERE ebeln EQ <fs_items>-po_number
                   AND ebelp EQ <fs_items>-po_item.

      ENDTRY.


      TRY.
          <fs_items>-lgobe = lt_txt_depo[ werks = <fs_items>-plant
                                         lgort = <fs_items>-stge_loc ]-lgobe.
        CATCH cx_sy_itab_line_not_found ##NO_HANDLER.
      ENDTRY.

    ENDLOOP.

  ENDMETHOD.


  METHOD is_creating_material.
    rv_yes = xsdbool( iv_tcode EQ c_tcode_create_mat ).
  ENDMETHOD.


  METHOD is_displaying_material.
    rv_yes = xsdbool( iv_tcode EQ c_tcode_display_mat ).
  ENDMETHOD.


  METHOD is_modifying_material.

    rv_yes = xsdbool(
      is_creating_material( iv_tcode ) EQ abap_true OR
      is_updating_material( iv_tcode ) EQ abap_true
    ).

  ENDMETHOD.


  METHOD is_updating_material.
    rv_yes = xsdbool( iv_tcode EQ c_tcode_edit_mat ).
  ENDMETHOD.


  METHOD save_karak_text.

    DATA: ls_header TYPE thead.

    CHECK iv_charg IS NOT INITIAL AND iv_matnr IS NOT INITIAL.

    ls_header-tdname+0(18) = iv_matnr.
    ls_header-tdname+22(10) = iv_charg.
    ls_header-tdid = c_tdid.
    ls_header-tdspras = c_langu.
    ls_header-tdobject = c_tdobject.

    DATA(lt_lines) = it_lines.

    CALL FUNCTION 'SAVE_TEXT'
      EXPORTING
        header          = ls_header
*       insert          = 'X'
        savemode_direct = 'X'
      TABLES
        lines           = lt_lines
      EXCEPTIONS
        id              = 1
        language        = 2
        name            = 3
        object          = 4
        OTHERS          = 5.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDMETHOD.
ENDCLASS.