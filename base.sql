
CREATE TABLE [��������_������������]
( 
	[��������_������������] varchar(20)  NULL ,
	[�����_������������] money  NULL ,
	[Id_������������]    integer  NOT NULL ,
	[Id_�������]         integer  NULL ,
	[id_�������]         integer  NULL 
)
go

ALTER TABLE [��������_������������]
	ADD CONSTRAINT [XPK��������_������������] PRIMARY KEY  CLUSTERED ([Id_������������] ASC)
go

CREATE TABLE [�����]
( 
	[������_��������]    date  NULL ,
	[���������_����_��������] date  NULL ,
	[�����_��_������]    integer  NULL ,
	[���������_��_������] money  NULL ,
	[����������_����_��_�������] money  NULL ,
	[Id_������]          integer  NOT NULL ,
	[id_���������]       integer  NULL 
)
go

ALTER TABLE [�����]
	ADD CONSTRAINT [XPK�����] PRIMARY KEY  CLUSTERED ([Id_������] ASC)
go

CREATE TABLE [������]
( 
	[id_���������]       integer  NOT NULL ,
	[Id_������]          integer  NOT NULL ,
	[�������]            char(18)  NULL ,
	[���]                char(18)  NULL ,
	[�����]              char(18)  NULL ,
	[�������]            char(18)  NULL ,
	[id_�������]         integer  NOT NULL ,
	[Id_��������]        integer  NULL ,
	[Id_�������]         integer  NULL ,
	[Id_������������]    integer  NULL ,
	[id]                 integer  NOT NULL 
)
go

ALTER TABLE [������]
	ADD CONSTRAINT [XPK������] PRIMARY KEY  CLUSTERED ([id] ASC)
go

CREATE TABLE [��������]
( 
	[id_���������]       integer  NOT NULL ,
	[������_��������]    date  NOT NULL ,
	[������]             varchar(20)  NOT NULL ,
	[�������]            varchar(20)  NOT NULL ,
	[�����_��_��������]  integer  NULL ,
	[���������_��_��������] integer  NULL ,
	[����������_����_��_�������_���������] integer  NOT NULL 
)
go

ALTER TABLE [��������]
	ADD CONSTRAINT [XPK��������] PRIMARY KEY  CLUSTERED ([id_���������] ASC)
go

CREATE TABLE [������]
( 
	[id_�������]         integer  NOT NULL ,
	[��������]           varchar()  NULL ,
	[��������]           varchar()  NULL ,
	[����_�������]       date  NULL ,
	[�����_�������]      money  NULL 
)
go

ALTER TABLE [������]
	ADD CONSTRAINT [XPK������] PRIMARY KEY  CLUSTERED ([id_�������] ASC)
go

CREATE TABLE [��������]
( 
	[����_��������]      date  NULL ,
	[����_��������_�����_�������������] date  NULL ,
	[�����_��������]     integer  NULL ,
	[���������_��������] money  NULL ,
	[Id_��������]        integer  NOT NULL ,
	[Id_������]          integer  NULL 
)
go

ALTER TABLE [��������]
	ADD CONSTRAINT [XPK��������] PRIMARY KEY  CLUSTERED ([Id_��������] ASC)
go

CREATE TABLE [�������]
( 
	[����_�������]       date  NULL ,
	[�����������_����_���������_�����������_�����������] date  NULL ,
	[���������_��_�������] money  NULL ,
	[Id_�������]         integer  NOT NULL ,
	[Id_��������]        integer  NULL 
)
go

ALTER TABLE [�������]
	ADD CONSTRAINT [XPK�������] PRIMARY KEY  CLUSTERED ([Id_�������] ASC)
go


ALTER TABLE [��������_������������]
	ADD CONSTRAINT [R_23] FOREIGN KEY ([Id_�������]) REFERENCES [�������]([Id_�������])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [��������_������������]
	ADD CONSTRAINT [R_24] FOREIGN KEY ([id_�������]) REFERENCES [������]([id_�������])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [�����]
	ADD CONSTRAINT [R_14] FOREIGN KEY ([id_���������]) REFERENCES [��������]([id_���������])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [������]
	ADD CONSTRAINT [R_26] FOREIGN KEY ([id_���������]) REFERENCES [��������]([id_���������])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [������]
	ADD CONSTRAINT [R_27] FOREIGN KEY ([Id_������]) REFERENCES [�����]([Id_������])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [������]
	ADD CONSTRAINT [R_28] FOREIGN KEY ([id_�������]) REFERENCES [������]([id_�������])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [������]
	ADD CONSTRAINT [R_29] FOREIGN KEY ([Id_��������]) REFERENCES [��������]([Id_��������])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [������]
	ADD CONSTRAINT [R_30] FOREIGN KEY ([Id_�������]) REFERENCES [�������]([Id_�������])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [������]
	ADD CONSTRAINT [R_31] FOREIGN KEY ([Id_������������]) REFERENCES [��������_������������]([Id_������������])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [��������]
	ADD CONSTRAINT [R_15] FOREIGN KEY ([Id_������]) REFERENCES [�����]([Id_������])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [�������]
	ADD CONSTRAINT [R_22] FOREIGN KEY ([Id_��������]) REFERENCES [��������]([Id_��������])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


CREATE TRIGGER tD_��������_������������ ON ��������_������������ FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ��������_������������ */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* ��������_������������  ������ on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00039a2a", PARENT_OWNER="", PARENT_TABLE="��������_������������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="Id_������������" */
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.Id_������������ = deleted.Id_������������
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete ��������_������������ because ������ exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ������  ��������_������������ on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="������"
    CHILD_OWNER="", CHILD_TABLE="��������_������������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="id_�������" */
    IF EXISTS (SELECT * FROM deleted,������
      WHERE
        /* %JoinFKPK(deleted,������," = "," AND") */
        deleted.id_������� = ������.id_������� AND
        NOT EXISTS (
          SELECT * FROM ��������_������������
          WHERE
            /* %JoinFKPK(��������_������������,������," = "," AND") */
            ��������_������������.id_������� = ������.id_�������
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ��������_������������ because ������ exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* �������  ��������_������������ on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�������"
    CHILD_OWNER="", CHILD_TABLE="��������_������������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Id_�������" */
    IF EXISTS (SELECT * FROM deleted,�������
      WHERE
        /* %JoinFKPK(deleted,�������," = "," AND") */
        deleted.Id_������� = �������.Id_������� AND
        NOT EXISTS (
          SELECT * FROM ��������_������������
          WHERE
            /* %JoinFKPK(��������_������������,�������," = "," AND") */
            ��������_������������.Id_������� = �������.Id_�������
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ��������_������������ because ������� exists.'
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


CREATE TRIGGER tU_��������_������������ ON ��������_������������ FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ��������_������������ */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insId_������������ integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* ��������_������������  ������ on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000434f2", PARENT_OWNER="", PARENT_TABLE="��������_������������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="Id_������������" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_������������)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.Id_������������ = deleted.Id_������������
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update ��������_������������ because ������ exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ������  ��������_������������ on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="������"
    CHILD_OWNER="", CHILD_TABLE="��������_������������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="id_�������" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_�������)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,������
        WHERE
          /* %JoinFKPK(inserted,������) */
          inserted.id_������� = ������.id_�������
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_������� IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ��������_������������ because ������ does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* �������  ��������_������������ on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�������"
    CHILD_OWNER="", CHILD_TABLE="��������_������������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Id_�������" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_�������)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,�������
        WHERE
          /* %JoinFKPK(inserted,�������) */
          inserted.Id_������� = �������.Id_�������
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_������� IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ��������_������������ because ������� does not exist.'
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




CREATE TRIGGER tD_����� ON ����� FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ����� */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* �����  ������ on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00031c2b", PARENT_OWNER="", PARENT_TABLE="�����"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="Id_������" */
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.Id_������ = deleted.Id_������
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete ����� because ������ exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* �����  �������� on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�����"
    CHILD_OWNER="", CHILD_TABLE="��������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Id_������" */
    IF EXISTS (
      SELECT * FROM deleted,��������
      WHERE
        /*  %JoinFKPK(��������,deleted," = "," AND") */
        ��������.Id_������ = deleted.Id_������
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete ����� because �������� exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ��������  ����� on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="�����"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="id_���������" */
    IF EXISTS (SELECT * FROM deleted,��������
      WHERE
        /* %JoinFKPK(deleted,��������," = "," AND") */
        deleted.id_��������� = ��������.id_��������� AND
        NOT EXISTS (
          SELECT * FROM �����
          WHERE
            /* %JoinFKPK(�����,��������," = "," AND") */
            �����.id_��������� = ��������.id_���������
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ����� because �������� exists.'
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


CREATE TRIGGER tU_����� ON ����� FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ����� */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insId_������ integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* �����  ������ on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00037d78", PARENT_OWNER="", PARENT_TABLE="�����"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="Id_������" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_������)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.Id_������ = deleted.Id_������
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update ����� because ������ exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* �����  �������� on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�����"
    CHILD_OWNER="", CHILD_TABLE="��������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Id_������" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_������)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,��������
      WHERE
        /*  %JoinFKPK(��������,deleted," = "," AND") */
        ��������.Id_������ = deleted.Id_������
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update ����� because �������� exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ��������  ����� on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="�����"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="id_���������" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_���������)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,��������
        WHERE
          /* %JoinFKPK(inserted,��������) */
          inserted.id_��������� = ��������.id_���������
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_��������� IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ����� because �������� does not exist.'
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




CREATE TRIGGER tD_������ ON ������ FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ������ */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* ��������_������������  ������ on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000723b0", PARENT_OWNER="", PARENT_TABLE="��������_������������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="Id_������������" */
    IF EXISTS (SELECT * FROM deleted,��������_������������
      WHERE
        /* %JoinFKPK(deleted,��������_������������," = "," AND") */
        deleted.Id_������������ = ��������_������������.Id_������������ AND
        NOT EXISTS (
          SELECT * FROM ������
          WHERE
            /* %JoinFKPK(������,��������_������������," = "," AND") */
            ������.Id_������������ = ��������_������������.Id_������������
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ������ because ��������_������������ exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* �������  ������ on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Id_�������" */
    IF EXISTS (SELECT * FROM deleted,�������
      WHERE
        /* %JoinFKPK(deleted,�������," = "," AND") */
        deleted.Id_������� = �������.Id_������� AND
        NOT EXISTS (
          SELECT * FROM ������
          WHERE
            /* %JoinFKPK(������,�������," = "," AND") */
            ������.Id_������� = �������.Id_�������
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ������ because ������� exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ��������  ������ on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="Id_��������" */
    IF EXISTS (SELECT * FROM deleted,��������
      WHERE
        /* %JoinFKPK(deleted,��������," = "," AND") */
        deleted.Id_�������� = ��������.Id_�������� AND
        NOT EXISTS (
          SELECT * FROM ������
          WHERE
            /* %JoinFKPK(������,��������," = "," AND") */
            ������.Id_�������� = ��������.Id_��������
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ������ because �������� exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ������  ������ on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="id_�������" */
    IF EXISTS (SELECT * FROM deleted,������
      WHERE
        /* %JoinFKPK(deleted,������," = "," AND") */
        deleted.id_������� = ������.id_������� AND
        NOT EXISTS (
          SELECT * FROM ������
          WHERE
            /* %JoinFKPK(������,������," = "," AND") */
            ������.id_������� = ������.id_�������
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ������ because ������ exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* �����  ������ on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�����"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="Id_������" */
    IF EXISTS (SELECT * FROM deleted,�����
      WHERE
        /* %JoinFKPK(deleted,�����," = "," AND") */
        deleted.Id_������ = �����.Id_������ AND
        NOT EXISTS (
          SELECT * FROM ������
          WHERE
            /* %JoinFKPK(������,�����," = "," AND") */
            ������.Id_������ = �����.Id_������
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ������ because ����� exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ��������  ������ on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="id_���������" */
    IF EXISTS (SELECT * FROM deleted,��������
      WHERE
        /* %JoinFKPK(deleted,��������," = "," AND") */
        deleted.id_��������� = ��������.id_��������� AND
        NOT EXISTS (
          SELECT * FROM ������
          WHERE
            /* %JoinFKPK(������,��������," = "," AND") */
            ������.id_��������� = ��������.id_���������
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ������ because �������� exists.'
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


CREATE TRIGGER tU_������ ON ������ FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ������ */
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
  /* ��������_������������  ������ on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000864f6", PARENT_OWNER="", PARENT_TABLE="��������_������������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="Id_������������" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_������������)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,��������_������������
        WHERE
          /* %JoinFKPK(inserted,��������_������������) */
          inserted.Id_������������ = ��������_������������.Id_������������
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_������������ IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ������ because ��������_������������ does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* �������  ������ on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Id_�������" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_�������)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,�������
        WHERE
          /* %JoinFKPK(inserted,�������) */
          inserted.Id_������� = �������.Id_�������
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_������� IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ������ because ������� does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ��������  ������ on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="Id_��������" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_��������)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,��������
        WHERE
          /* %JoinFKPK(inserted,��������) */
          inserted.Id_�������� = ��������.Id_��������
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_�������� IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ������ because �������� does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ������  ������ on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="id_�������" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_�������)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,������
        WHERE
          /* %JoinFKPK(inserted,������) */
          inserted.id_������� = ������.id_�������
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ������ because ������ does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* �����  ������ on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�����"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="Id_������" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_������)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,�����
        WHERE
          /* %JoinFKPK(inserted,�����) */
          inserted.Id_������ = �����.Id_������
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ������ because ����� does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ��������  ������ on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="id_���������" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_���������)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,��������
        WHERE
          /* %JoinFKPK(inserted,��������) */
          inserted.id_��������� = ��������.id_���������
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ������ because �������� does not exist.'
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




CREATE TRIGGER tD_�������� ON �������� FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on �������� */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* ��������  ������ on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001ea6d", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="id_���������" */
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.id_��������� = deleted.id_���������
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete �������� because ������ exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ��������  ����� on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="�����"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="id_���������" */
    IF EXISTS (
      SELECT * FROM deleted,�����
      WHERE
        /*  %JoinFKPK(�����,deleted," = "," AND") */
        �����.id_��������� = deleted.id_���������
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete �������� because ����� exists.'
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


CREATE TRIGGER tU_�������� ON �������� FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on �������� */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid_��������� integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* ��������  ������ on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00022747", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="id_���������" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id_���������)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.id_��������� = deleted.id_���������
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update �������� because ������ exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ��������  ����� on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="�����"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="id_���������" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id_���������)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,�����
      WHERE
        /*  %JoinFKPK(�����,deleted," = "," AND") */
        �����.id_��������� = deleted.id_���������
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update �������� because ����� exists.'
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




CREATE TRIGGER tD_������ ON ������ FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ������ */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* ������  ������ on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00021096", PARENT_OWNER="", PARENT_TABLE="������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="id_�������" */
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.id_������� = deleted.id_�������
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete ������ because ������ exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ������  ��������_������������ on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="������"
    CHILD_OWNER="", CHILD_TABLE="��������_������������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="id_�������" */
    IF EXISTS (
      SELECT * FROM deleted,��������_������������
      WHERE
        /*  %JoinFKPK(��������_������������,deleted," = "," AND") */
        ��������_������������.id_������� = deleted.id_�������
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete ������ because ��������_������������ exists.'
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


CREATE TRIGGER tU_������ ON ������ FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ������ */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid_������� integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* ������  ������ on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002464a", PARENT_OWNER="", PARENT_TABLE="������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="id_�������" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id_�������)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.id_������� = deleted.id_�������
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update ������ because ������ exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ������  ��������_������������ on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="������"
    CHILD_OWNER="", CHILD_TABLE="��������_������������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="id_�������" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id_�������)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,��������_������������
      WHERE
        /*  %JoinFKPK(��������_������������,deleted," = "," AND") */
        ��������_������������.id_������� = deleted.id_�������
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update ������ because ��������_������������ exists.'
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




CREATE TRIGGER tD_�������� ON �������� FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on �������� */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* ��������  ������ on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000313c8", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="Id_��������" */
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.Id_�������� = deleted.Id_��������
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete �������� because ������ exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ��������  ������� on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="�������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Id_��������" */
    IF EXISTS (
      SELECT * FROM deleted,�������
      WHERE
        /*  %JoinFKPK(�������,deleted," = "," AND") */
        �������.Id_�������� = deleted.Id_��������
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete �������� because ������� exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* �����  �������� on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�����"
    CHILD_OWNER="", CHILD_TABLE="��������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Id_������" */
    IF EXISTS (SELECT * FROM deleted,�����
      WHERE
        /* %JoinFKPK(deleted,�����," = "," AND") */
        deleted.Id_������ = �����.Id_������ AND
        NOT EXISTS (
          SELECT * FROM ��������
          WHERE
            /* %JoinFKPK(��������,�����," = "," AND") */
            ��������.Id_������ = �����.Id_������
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last �������� because ����� exists.'
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


CREATE TRIGGER tU_�������� ON �������� FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on �������� */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insId_�������� integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* ��������  ������ on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003802d", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="Id_��������" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_��������)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.Id_�������� = deleted.Id_��������
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update �������� because ������ exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ��������  ������� on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="�������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Id_��������" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_��������)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,�������
      WHERE
        /*  %JoinFKPK(�������,deleted," = "," AND") */
        �������.Id_�������� = deleted.Id_��������
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update �������� because ������� exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* �����  �������� on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�����"
    CHILD_OWNER="", CHILD_TABLE="��������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Id_������" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_������)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,�����
        WHERE
          /* %JoinFKPK(inserted,�����) */
          inserted.Id_������ = �����.Id_������
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_������ IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update �������� because ����� does not exist.'
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




CREATE TRIGGER tD_������� ON ������� FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ������� */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* �������  ������ on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00033d60", PARENT_OWNER="", PARENT_TABLE="�������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Id_�������" */
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.Id_������� = deleted.Id_�������
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete ������� because ������ exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* �������  ��������_������������ on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�������"
    CHILD_OWNER="", CHILD_TABLE="��������_������������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Id_�������" */
    IF EXISTS (
      SELECT * FROM deleted,��������_������������
      WHERE
        /*  %JoinFKPK(��������_������������,deleted," = "," AND") */
        ��������_������������.Id_������� = deleted.Id_�������
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete ������� because ��������_������������ exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ��������  ������� on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="�������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Id_��������" */
    IF EXISTS (SELECT * FROM deleted,��������
      WHERE
        /* %JoinFKPK(deleted,��������," = "," AND") */
        deleted.Id_�������� = ��������.Id_�������� AND
        NOT EXISTS (
          SELECT * FROM �������
          WHERE
            /* %JoinFKPK(�������,��������," = "," AND") */
            �������.Id_�������� = ��������.Id_��������
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ������� because �������� exists.'
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


CREATE TRIGGER tU_������� ON ������� FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ������� */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insId_������� integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* �������  ������ on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003cb53", PARENT_OWNER="", PARENT_TABLE="�������"
    CHILD_OWNER="", CHILD_TABLE="������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Id_�������" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_�������)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,������
      WHERE
        /*  %JoinFKPK(������,deleted," = "," AND") */
        ������.Id_������� = deleted.Id_�������
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update ������� because ������ exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* �������  ��������_������������ on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="�������"
    CHILD_OWNER="", CHILD_TABLE="��������_������������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Id_�������" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Id_�������)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,��������_������������
      WHERE
        /*  %JoinFKPK(��������_������������,deleted," = "," AND") */
        ��������_������������.Id_������� = deleted.Id_�������
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update ������� because ��������_������������ exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ��������  ������� on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="��������"
    CHILD_OWNER="", CHILD_TABLE="�������"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Id_��������" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Id_��������)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,��������
        WHERE
          /* %JoinFKPK(inserted,��������) */
          inserted.Id_�������� = ��������.Id_��������
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Id_�������� IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ������� because �������� does not exist.'
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


