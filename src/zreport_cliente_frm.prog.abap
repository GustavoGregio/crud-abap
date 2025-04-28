FORM excluir_cliente USING ud_zclinr TYPE zclinr_e.
  SELECT SINGLE *
    INTO gs_cliente
    FROM zsd_cliente
   WHERE zclinr = ud_zclinr.

  IF sy-subrc <> 0.
    MESSAGE |O cliente { ud_zclinr } não existe| TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  DELETE FROM zsd_cliente WHERE zclinr = ud_zclinr.
  IF sy-subrc = 0.
    MESSAGE 'Cliente excluido com sucesso' TYPE 'S'.
  ELSE.
    MESSAGE 'Erro em excluir cliente' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
FORM show_alv.
  DATA: ls_fieldcat TYPE slis_fieldcat_alv.
  DATA: lt_fieldcat TYPE STANDARD TABLE OF slis_fieldcat_alv.

  CLEAR lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ZCLINR'.
  ls_fieldcat-seltext_m = 'Cód.Cliente'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ERDAT'.
  ls_fieldcat-seltext_m = 'Data Criação'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'NOME'.
  ls_fieldcat-seltext_m = 'Nome'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'EMAIL'.
  ls_fieldcat-seltext_m = 'E-mail'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'LIMITE_CREDITO'.
  ls_fieldcat-seltext_m = 'Limite'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'STATUS'.
  ls_fieldcat-seltext_m = 'Status'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_grid_title             = 'Relatório de Clientes'
      it_fieldcat              = lt_fieldcat
      i_save                   = 'X'
      i_callback_user_command  = 'HANDLE_ALV_EVENT'
      i_callback_pf_status_set = 'SET_PF_STATUS'
    TABLES
      t_outtab                 = gt_cliente
    EXCEPTIONS
      program_error            = 1
      others                   = 2.
ENDFORM.
FORM SET_PF_STATUS USING RT_EXTAB TYPE SLIS_T_EXTAB.
  SET PF-STATUS 'STANDARD'.
ENDFORM.
FORM HANDLE_ALV_EVENT
  USING ucomm    TYPE syucomm
        selfield TYPE slis_selfield.

  DATA: ld_field TYPE char10.

  READ TABLE gt_cliente INTO gs_cliente INDEX selfield-tabindex.
  ld_field = gs_cliente-zclinr.
  CONDENSE ld_field NO-GAPS.

  SET PARAMETER ID 'ZCLINR' FIELD ld_field.

  CASE ucomm.
    WHEN 'CREATE'.
      CALL TRANSACTION 'ZSD001'.
    WHEN 'EDIT'.
      CALL TRANSACTION 'ZSD002' AND SKIP FIRST SCREEN.
    WHEN 'DELETE'.
      PERFORM excluir_cliente USING gs_cliente-zclinr.
  ENDCASE.

  PERFORM consultar.
  selfield-refresh = 'X'.
ENDFORM.
FORM consultar.
    SELECT *
    INTO TABLE gt_cliente
    FROM zsd_cliente UP TO p_limit ROWS
   WHERE zclinr         IN s_zclinr[]
     AND erdat          IN s_erdat[]
     AND nome           IN s_nome[]
     AND email          IN s_email[]
     AND limite_credito IN s_lcred[]
     AND status         IN s_status[].

ENDFORM.
