USE [InventoryAGr]
GO
/****** Object:  Trigger [dbo].[IGV_TOTAL]    Script Date: 12/01/2020 05:48:28 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[IGV_TOTAL] ON [dbo].[DetalleOrden]
  AFTER INSERT, update
AS 
BEGIN
   --SET NOCOUNT ON agregado para evitar conjuntos de resultados adicionales
   -- interferir con las instrucciones SELECT.
  SET NOCOUNT ON;

  -- obtener el último valor de identificación del registro insertado o actualizado
  DECLARE @IDO INT, @IGV decimal
  SELECT @IDO = iddetalleorden, @IGV = 0.18 * valor 
  FROM INSERTED 

  -- Insertar declaraciones para desencadenar aquí
  UPDATE DetalleOrden 
  set IGV  = @IGV , total= valor + @IGV  WHERE 
		iddetalleorden=@IDO

END