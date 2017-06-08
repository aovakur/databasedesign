
CREATE TABLE [Документ_выравнивания]
( 
	[Документ_выравнивания] varchar(20)  NULL ,
	[Сумма_выравнивания] money  NULL ,
	[Id_Выравнивания]    integer  NOT NULL ,
	[Id_Фактуры]         integer  NULL ,
	[id_Платежа]         integer  NULL 
)
go

ALTER TABLE [Документ_выравнивания]
	ADD CONSTRAINT [XPKДокумент_выравнивания] PRIMARY KEY  CLUSTERED ([Id_Выравнивания] ASC)
go

CREATE TABLE [Заказ]
( 
	[Период_действия]    date  NULL ,
	[Требуемая_дата_поставки] date  NULL ,
	[Объем_по_заказу]    integer  NULL ,
	[Стоимость_по_заказу] money  NULL ,
	[Договорная_цена_по_позиции] money  NULL ,
	[Id_Заказа]          integer  NOT NULL ,
	[id_Контракта]       integer  NULL 
)
go

ALTER TABLE [Заказ]
	ADD CONSTRAINT [XPKЗаказ] PRIMARY KEY  CLUSTERED ([Id_Заказа] ASC)
go

CREATE TABLE [Клиент]
( 
	[id_Контракта]       integer  NOT NULL ,
	[Id_Заказа]          integer  NOT NULL ,
	[Фамилия]            char(18)  NULL ,
	[Имя]                char(18)  NULL ,
	[Адрес]              char(18)  NULL ,
	[Телефон]            char(18)  NULL ,
	[id_Платежа]         integer  NOT NULL ,
	[Id_Поставки]        integer  NULL ,
	[Id_Фактуры]         integer  NULL ,
	[Id_Выравнивания]    integer  NULL ,
	[id]                 integer  NOT NULL 
)
go

ALTER TABLE [Клиент]
	ADD CONSTRAINT [XPKКлиент] PRIMARY KEY  CLUSTERED ([id] ASC)
go

CREATE TABLE [Контракт]
( 
	[id_Контракта]       integer  NOT NULL ,
	[Период_действия]    date  NOT NULL ,
	[Регион]             varchar(20)  NOT NULL ,
	[Продукт]            varchar(20)  NOT NULL ,
	[Объем_по_договору]  integer  NULL ,
	[Стоимость_по_договору] integer  NULL ,
	[Договорная_цена_по_позиции_контракта] integer  NOT NULL 
)
go

ALTER TABLE [Контракт]
	ADD CONSTRAINT [XPKКонтракт] PRIMARY KEY  CLUSTERED ([id_Контракта] ASC)
go

CREATE TABLE [Платеж]
( 
	[id_Платежа]         integer  NOT NULL ,
	[Контракт]           varchar()  NULL ,
	[Заказчик]           varchar()  NULL ,
	[Дата_платежа]       date  NULL ,
	[Сумма_платежа]      money  NULL 
)
go

ALTER TABLE [Платеж]
	ADD CONSTRAINT [XPKПлатеж] PRIMARY KEY  CLUSTERED ([id_Платежа] ASC)
go

CREATE TABLE [Поставка]
( 
	[Дата_отгрузки]      date  NULL ,
	[Дата_передачи_права_собственности] date  NULL ,
	[Объем_поставки]     integer  NULL ,
	[Стоимость_поставки] money  NULL ,
	[Id_Поставки]        integer  NOT NULL ,
	[Id_Заказа]          integer  NULL 
)
go

ALTER TABLE [Поставка]
	ADD CONSTRAINT [XPKПоставка] PRIMARY KEY  CLUSTERED ([Id_Поставки] ASC)
go

CREATE TABLE [Фактура]
( 
	[Дата_фактуры]       date  NULL ,
	[Планируемая_дата_погашения_дебиторской_задолжности] date  NULL ,
	[Стоимость_по_фактуре] money  NULL ,
	[Id_Фактуры]         integer  NOT NULL ,
	[Id_Поставки]        integer  NULL 
)
go

ALTER TABLE [Фактура]
	ADD CONSTRAINT [XPKФактура] PRIMARY KEY  CLUSTERED ([Id_Фактуры] ASC)
go


ALTER TABLE [Документ_выравнивания]
	ADD CONSTRAINT [R_23] FOREIGN KEY ([Id_Фактуры]) REFERENCES [Фактура]([Id_Фактуры])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Документ_выравнивания]
	ADD CONSTRAINT [R_24] FOREIGN KEY ([id_Платежа]) REFERENCES [Платеж]([id_Платежа])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Заказ]
	ADD CONSTRAINT [R_14] FOREIGN KEY ([id_Контракта]) REFERENCES [Контракт]([id_Контракта])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Клиент]
	ADD CONSTRAINT [R_26] FOREIGN KEY ([id_Контракта]) REFERENCES [Контракт]([id_Контракта])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Клиент]
	ADD CONSTRAINT [R_27] FOREIGN KEY ([Id_Заказа]) REFERENCES [Заказ]([Id_Заказа])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Клиент]
	ADD CONSTRAINT [R_28] FOREIGN KEY ([id_Платежа]) REFERENCES [Платеж]([id_Платежа])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Клиент]
	ADD CONSTRAINT [R_29] FOREIGN KEY ([Id_Поставки]) REFERENCES [Поставка]([Id_Поставки])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Клиент]
	ADD CONSTRAINT [R_30] FOREIGN KEY ([Id_Фактуры]) REFERENCES [Фактура]([Id_Фактуры])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Клиент]
	ADD CONSTRAINT [R_31] FOREIGN KEY ([Id_Выравнивания]) REFERENCES [Документ_выравнивания]([Id_Выравнивания])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Поставка]
	ADD CONSTRAINT [R_15] FOREIGN KEY ([Id_Заказа]) REFERENCES [Заказ]([Id_Заказа])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Фактура]
	ADD CONSTRAINT [R_22] FOREIGN KEY ([Id_Поставки]) REFERENCES [Поставка]([Id_Поставки])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


CREATE TRIGGER tD_Документ_выравнивания ON Документ_выравнивания FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Документ_выравнивания */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Документ_выравнивания  Клиент on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00039a2a", PARENT_OWNER="", PARENT_TABLE="Документ_выравнивания"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="Id_Выравнивания" */
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.Id_Выравнивания = deleted.Id_Выравнивания
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Документ_выравнивания because Клиент exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Платеж  Документ_выравнивания on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Платеж"
    CHILD_OWNER="", CHILD_TABLE="Документ_выравнивания"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="id_Платежа" */
    IF EXISTS (SELECT * FROM deleted,Платеж
      WHERE
        /* %JoinFKPK(deleted,Платеж," = "," AND") */
        deleted.id_Платежа = Платеж.id_Платежа AND
        NOT EXISTS (
          SELECT * FROM Документ_выравнивания
          WHERE
            /* %JoinFKPK(Документ_выравнивания,Платеж," = "," AND") */
            Документ_выравнивания.id_Платежа = Платеж.id_Платежа
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Документ_выравнивания because Платеж exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Фактура  Документ_выравнивания on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Фактура"
    CHILD_OWNER="", CHILD_TABLE="Документ_выравнивания"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Id_Фактуры" */
    IF EXISTS (SELECT * FROM deleted,Фактура
      WHERE
        /* %JoinFKPK(deleted,Фактура," = "," AND") */
        deleted.Id_Фактуры = Фактура.Id_Фактуры AND
        NOT EXISTS (
          SELECT * FROM Документ_выравнивания
          WHERE
            /* %JoinFKPK(Документ_выравнивания,Фактура," = "," AND") */
            Документ_выравнивания.Id_Фактуры = Фактура.Id_Фактуры
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Документ_выравнивания because Фактура exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Документ_выравнивания ON Документ_выравнивания FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Документ_выравнивания */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insId_Выравнивания integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Документ_выравнивания  Клиент on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000434f2", PARENT_OWNER="", PARENT_TABLE="Документ_выравнивания"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="Id_Выравнивания" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_Выравнивания)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.Id_Выравнивания = deleted.Id_Выравнивания
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Документ_выравнивания because Клиент exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Платеж  Документ_выравнивания on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Платеж"
    CHILD_OWNER="", CHILD_TABLE="Документ_выравнивания"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="id_Платежа" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_Платежа)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Платеж
        WHERE
          /* %JoinFKPK(inserted,Платеж) */
          inserted.id_Платежа = Платеж.id_Платежа
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_Платежа IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Документ_выравнивания because Платеж does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Фактура  Документ_выравнивания on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Фактура"
    CHILD_OWNER="", CHILD_TABLE="Документ_выравнивания"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Id_Фактуры" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_Фактуры)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Фактура
        WHERE
          /* %JoinFKPK(inserted,Фактура) */
          inserted.Id_Фактуры = Фактура.Id_Фактуры
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_Фактуры IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Документ_выравнивания because Фактура does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Заказ ON Заказ FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Заказ */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Заказ  Клиент on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00031c2b", PARENT_OWNER="", PARENT_TABLE="Заказ"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="Id_Заказа" */
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.Id_Заказа = deleted.Id_Заказа
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Заказ because Клиент exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Заказ  Поставка on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Заказ"
    CHILD_OWNER="", CHILD_TABLE="Поставка"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Id_Заказа" */
    IF EXISTS (
      SELECT * FROM deleted,Поставка
      WHERE
        /*  %JoinFKPK(Поставка,deleted," = "," AND") */
        Поставка.Id_Заказа = deleted.Id_Заказа
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Заказ because Поставка exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Контракт  Заказ on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Контракт"
    CHILD_OWNER="", CHILD_TABLE="Заказ"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="id_Контракта" */
    IF EXISTS (SELECT * FROM deleted,Контракт
      WHERE
        /* %JoinFKPK(deleted,Контракт," = "," AND") */
        deleted.id_Контракта = Контракт.id_Контракта AND
        NOT EXISTS (
          SELECT * FROM Заказ
          WHERE
            /* %JoinFKPK(Заказ,Контракт," = "," AND") */
            Заказ.id_Контракта = Контракт.id_Контракта
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Заказ because Контракт exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Заказ ON Заказ FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Заказ */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insId_Заказа integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Заказ  Клиент on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00037d78", PARENT_OWNER="", PARENT_TABLE="Заказ"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="Id_Заказа" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_Заказа)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.Id_Заказа = deleted.Id_Заказа
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Заказ because Клиент exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Заказ  Поставка on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Заказ"
    CHILD_OWNER="", CHILD_TABLE="Поставка"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Id_Заказа" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_Заказа)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Поставка
      WHERE
        /*  %JoinFKPK(Поставка,deleted," = "," AND") */
        Поставка.Id_Заказа = deleted.Id_Заказа
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Заказ because Поставка exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Контракт  Заказ on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Контракт"
    CHILD_OWNER="", CHILD_TABLE="Заказ"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="id_Контракта" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_Контракта)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Контракт
        WHERE
          /* %JoinFKPK(inserted,Контракт) */
          inserted.id_Контракта = Контракт.id_Контракта
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_Контракта IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Заказ because Контракт does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Клиент ON Клиент FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Клиент */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Документ_выравнивания  Клиент on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000723b0", PARENT_OWNER="", PARENT_TABLE="Документ_выравнивания"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="Id_Выравнивания" */
    IF EXISTS (SELECT * FROM deleted,Документ_выравнивания
      WHERE
        /* %JoinFKPK(deleted,Документ_выравнивания," = "," AND") */
        deleted.Id_Выравнивания = Документ_выравнивания.Id_Выравнивания AND
        NOT EXISTS (
          SELECT * FROM Клиент
          WHERE
            /* %JoinFKPK(Клиент,Документ_выравнивания," = "," AND") */
            Клиент.Id_Выравнивания = Документ_выравнивания.Id_Выравнивания
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Клиент because Документ_выравнивания exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Фактура  Клиент on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Фактура"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Id_Фактуры" */
    IF EXISTS (SELECT * FROM deleted,Фактура
      WHERE
        /* %JoinFKPK(deleted,Фактура," = "," AND") */
        deleted.Id_Фактуры = Фактура.Id_Фактуры AND
        NOT EXISTS (
          SELECT * FROM Клиент
          WHERE
            /* %JoinFKPK(Клиент,Фактура," = "," AND") */
            Клиент.Id_Фактуры = Фактура.Id_Фактуры
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Клиент because Фактура exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Поставка  Клиент on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Поставка"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="Id_Поставки" */
    IF EXISTS (SELECT * FROM deleted,Поставка
      WHERE
        /* %JoinFKPK(deleted,Поставка," = "," AND") */
        deleted.Id_Поставки = Поставка.Id_Поставки AND
        NOT EXISTS (
          SELECT * FROM Клиент
          WHERE
            /* %JoinFKPK(Клиент,Поставка," = "," AND") */
            Клиент.Id_Поставки = Поставка.Id_Поставки
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Клиент because Поставка exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Платеж  Клиент on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Платеж"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="id_Платежа" */
    IF EXISTS (SELECT * FROM deleted,Платеж
      WHERE
        /* %JoinFKPK(deleted,Платеж," = "," AND") */
        deleted.id_Платежа = Платеж.id_Платежа AND
        NOT EXISTS (
          SELECT * FROM Клиент
          WHERE
            /* %JoinFKPK(Клиент,Платеж," = "," AND") */
            Клиент.id_Платежа = Платеж.id_Платежа
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Клиент because Платеж exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Заказ  Клиент on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Заказ"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="Id_Заказа" */
    IF EXISTS (SELECT * FROM deleted,Заказ
      WHERE
        /* %JoinFKPK(deleted,Заказ," = "," AND") */
        deleted.Id_Заказа = Заказ.Id_Заказа AND
        NOT EXISTS (
          SELECT * FROM Клиент
          WHERE
            /* %JoinFKPK(Клиент,Заказ," = "," AND") */
            Клиент.Id_Заказа = Заказ.Id_Заказа
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Клиент because Заказ exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Контракт  Клиент on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Контракт"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="id_Контракта" */
    IF EXISTS (SELECT * FROM deleted,Контракт
      WHERE
        /* %JoinFKPK(deleted,Контракт," = "," AND") */
        deleted.id_Контракта = Контракт.id_Контракта AND
        NOT EXISTS (
          SELECT * FROM Клиент
          WHERE
            /* %JoinFKPK(Клиент,Контракт," = "," AND") */
            Клиент.id_Контракта = Контракт.id_Контракта
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Клиент because Контракт exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Клиент ON Клиент FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Клиент */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Документ_выравнивания  Клиент on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000864f6", PARENT_OWNER="", PARENT_TABLE="Документ_выравнивания"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="Id_Выравнивания" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_Выравнивания)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Документ_выравнивания
        WHERE
          /* %JoinFKPK(inserted,Документ_выравнивания) */
          inserted.Id_Выравнивания = Документ_выравнивания.Id_Выравнивания
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_Выравнивания IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Клиент because Документ_выравнивания does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Фактура  Клиент on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Фактура"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Id_Фактуры" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_Фактуры)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Фактура
        WHERE
          /* %JoinFKPK(inserted,Фактура) */
          inserted.Id_Фактуры = Фактура.Id_Фактуры
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_Фактуры IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Клиент because Фактура does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Поставка  Клиент on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Поставка"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="Id_Поставки" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_Поставки)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Поставка
        WHERE
          /* %JoinFKPK(inserted,Поставка) */
          inserted.Id_Поставки = Поставка.Id_Поставки
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_Поставки IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Клиент because Поставка does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Платеж  Клиент on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Платеж"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="id_Платежа" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_Платежа)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Платеж
        WHERE
          /* %JoinFKPK(inserted,Платеж) */
          inserted.id_Платежа = Платеж.id_Платежа
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Клиент because Платеж does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Заказ  Клиент on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Заказ"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="Id_Заказа" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_Заказа)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Заказ
        WHERE
          /* %JoinFKPK(inserted,Заказ) */
          inserted.Id_Заказа = Заказ.Id_Заказа
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Клиент because Заказ does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Контракт  Клиент on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Контракт"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="id_Контракта" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_Контракта)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Контракт
        WHERE
          /* %JoinFKPK(inserted,Контракт) */
          inserted.id_Контракта = Контракт.id_Контракта
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Клиент because Контракт does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Контракт ON Контракт FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Контракт */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Контракт  Клиент on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001ea6d", PARENT_OWNER="", PARENT_TABLE="Контракт"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="id_Контракта" */
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.id_Контракта = deleted.id_Контракта
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Контракт because Клиент exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Контракт  Заказ on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Контракт"
    CHILD_OWNER="", CHILD_TABLE="Заказ"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="id_Контракта" */
    IF EXISTS (
      SELECT * FROM deleted,Заказ
      WHERE
        /*  %JoinFKPK(Заказ,deleted," = "," AND") */
        Заказ.id_Контракта = deleted.id_Контракта
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Контракт because Заказ exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Контракт ON Контракт FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Контракт */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid_Контракта integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Контракт  Клиент on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00022747", PARENT_OWNER="", PARENT_TABLE="Контракт"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="id_Контракта" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id_Контракта)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.id_Контракта = deleted.id_Контракта
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Контракт because Клиент exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Контракт  Заказ on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Контракт"
    CHILD_OWNER="", CHILD_TABLE="Заказ"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="id_Контракта" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id_Контракта)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Заказ
      WHERE
        /*  %JoinFKPK(Заказ,deleted," = "," AND") */
        Заказ.id_Контракта = deleted.id_Контракта
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Контракт because Заказ exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Платеж ON Платеж FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Платеж */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Платеж  Клиент on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00021096", PARENT_OWNER="", PARENT_TABLE="Платеж"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="id_Платежа" */
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.id_Платежа = deleted.id_Платежа
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Платеж because Клиент exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Платеж  Документ_выравнивания on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Платеж"
    CHILD_OWNER="", CHILD_TABLE="Документ_выравнивания"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="id_Платежа" */
    IF EXISTS (
      SELECT * FROM deleted,Документ_выравнивания
      WHERE
        /*  %JoinFKPK(Документ_выравнивания,deleted," = "," AND") */
        Документ_выравнивания.id_Платежа = deleted.id_Платежа
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Платеж because Документ_выравнивания exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Платеж ON Платеж FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Платеж */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid_Платежа integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Платеж  Клиент on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002464a", PARENT_OWNER="", PARENT_TABLE="Платеж"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="id_Платежа" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id_Платежа)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.id_Платежа = deleted.id_Платежа
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Платеж because Клиент exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Платеж  Документ_выравнивания on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Платеж"
    CHILD_OWNER="", CHILD_TABLE="Документ_выравнивания"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="id_Платежа" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id_Платежа)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Документ_выравнивания
      WHERE
        /*  %JoinFKPK(Документ_выравнивания,deleted," = "," AND") */
        Документ_выравнивания.id_Платежа = deleted.id_Платежа
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Платеж because Документ_выравнивания exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Поставка ON Поставка FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Поставка */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Поставка  Клиент on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000313c8", PARENT_OWNER="", PARENT_TABLE="Поставка"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="Id_Поставки" */
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.Id_Поставки = deleted.Id_Поставки
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Поставка because Клиент exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Поставка  Фактура on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Поставка"
    CHILD_OWNER="", CHILD_TABLE="Фактура"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Id_Поставки" */
    IF EXISTS (
      SELECT * FROM deleted,Фактура
      WHERE
        /*  %JoinFKPK(Фактура,deleted," = "," AND") */
        Фактура.Id_Поставки = deleted.Id_Поставки
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Поставка because Фактура exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Заказ  Поставка on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Заказ"
    CHILD_OWNER="", CHILD_TABLE="Поставка"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Id_Заказа" */
    IF EXISTS (SELECT * FROM deleted,Заказ
      WHERE
        /* %JoinFKPK(deleted,Заказ," = "," AND") */
        deleted.Id_Заказа = Заказ.Id_Заказа AND
        NOT EXISTS (
          SELECT * FROM Поставка
          WHERE
            /* %JoinFKPK(Поставка,Заказ," = "," AND") */
            Поставка.Id_Заказа = Заказ.Id_Заказа
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Поставка because Заказ exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Поставка ON Поставка FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Поставка */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insId_Поставки integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Поставка  Клиент on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003802d", PARENT_OWNER="", PARENT_TABLE="Поставка"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="Id_Поставки" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_Поставки)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.Id_Поставки = deleted.Id_Поставки
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Поставка because Клиент exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Поставка  Фактура on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Поставка"
    CHILD_OWNER="", CHILD_TABLE="Фактура"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Id_Поставки" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_Поставки)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Фактура
      WHERE
        /*  %JoinFKPK(Фактура,deleted," = "," AND") */
        Фактура.Id_Поставки = deleted.Id_Поставки
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Поставка because Фактура exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Заказ  Поставка on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Заказ"
    CHILD_OWNER="", CHILD_TABLE="Поставка"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Id_Заказа" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_Заказа)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Заказ
        WHERE
          /* %JoinFKPK(inserted,Заказ) */
          inserted.Id_Заказа = Заказ.Id_Заказа
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_Заказа IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Поставка because Заказ does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Фактура ON Фактура FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Фактура */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Фактура  Клиент on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00033d60", PARENT_OWNER="", PARENT_TABLE="Фактура"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Id_Фактуры" */
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.Id_Фактуры = deleted.Id_Фактуры
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Фактура because Клиент exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Фактура  Документ_выравнивания on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Фактура"
    CHILD_OWNER="", CHILD_TABLE="Документ_выравнивания"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Id_Фактуры" */
    IF EXISTS (
      SELECT * FROM deleted,Документ_выравнивания
      WHERE
        /*  %JoinFKPK(Документ_выравнивания,deleted," = "," AND") */
        Документ_выравнивания.Id_Фактуры = deleted.Id_Фактуры
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Фактура because Документ_выравнивания exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Поставка  Фактура on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Поставка"
    CHILD_OWNER="", CHILD_TABLE="Фактура"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Id_Поставки" */
    IF EXISTS (SELECT * FROM deleted,Поставка
      WHERE
        /* %JoinFKPK(deleted,Поставка," = "," AND") */
        deleted.Id_Поставки = Поставка.Id_Поставки AND
        NOT EXISTS (
          SELECT * FROM Фактура
          WHERE
            /* %JoinFKPK(Фактура,Поставка," = "," AND") */
            Фактура.Id_Поставки = Поставка.Id_Поставки
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Фактура because Поставка exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Фактура ON Фактура FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Фактура */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insId_Фактуры integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Фактура  Клиент on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003cb53", PARENT_OWNER="", PARENT_TABLE="Фактура"
    CHILD_OWNER="", CHILD_TABLE="Клиент"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Id_Фактуры" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_Фактуры)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Клиент
      WHERE
        /*  %JoinFKPK(Клиент,deleted," = "," AND") */
        Клиент.Id_Фактуры = deleted.Id_Фактуры
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Фактура because Клиент exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Фактура  Документ_выравнивания on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Фактура"
    CHILD_OWNER="", CHILD_TABLE="Документ_выравнивания"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Id_Фактуры" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_Фактуры)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Документ_выравнивания
      WHERE
        /*  %JoinFKPK(Документ_выравнивания,deleted," = "," AND") */
        Документ_выравнивания.Id_Фактуры = deleted.Id_Фактуры
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Фактура because Документ_выравнивания exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Поставка  Фактура on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Поставка"
    CHILD_OWNER="", CHILD_TABLE="Фактура"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Id_Поставки" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_Поставки)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Поставка
        WHERE
          /* %JoinFKPK(inserted,Поставка) */
          inserted.Id_Поставки = Поставка.Id_Поставки
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_Поставки IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Фактура because Поставка does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


