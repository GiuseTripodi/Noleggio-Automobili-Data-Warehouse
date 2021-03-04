-- Populate aggregate table progetto_b_noleggio_a_1
INSERT INTO `progetto_b_noleggio_a_1` (
    `dt_automobile_modello`,
    `dt_citta_stato`,
    `ft_noleggio_auto_MPG_medio`,
    `ft_noleggio_auto_carburante_me`,
    `ft_noleggio_auto_distanza_chil`,
    `ft_noleggio_auto_costo_assicur`,
    `ft_noleggio_auto_eta_media_cli`,
    `ft_noleggio_auto_importo_pagat`,
    `ft_noleggio_auto_numero_client`,
    `ft_noleggio_auto_numero_nolegg`,
    `ft_noleggio_auto_sconto_medio`,
    `ft_noleggio_auto_importo_tasse`,
    `ft_noleggio_auto_fact_count`)
select
    `dt_automobile`.`modello` as `dt_automobile_modello`,
    `dt_citta_2`.`stato` as `dt_citta_stato`,
    avg(`ft_noleggio_auto`.`MPC_medio`) as `ft_noleggio_auto_MPG_medio`,
    avg(`ft_noleggio_auto`.`carburante_medio`) as `ft_noleggio_auto_carburante_me`,
    avg(`ft_noleggio_auto`.`chilometri_medi`) as `ft_noleggio_auto_distanza_chil`,
    avg(`ft_noleggio_auto`.`costo_assicurazione_medio`) as `ft_noleggio_auto_costo_assicur`,
    avg(`ft_noleggio_auto`.`eta_media_clienti`) as `ft_noleggio_auto_eta_media_cli`,
    avg(`ft_noleggio_auto`.`importo_pagato_medio`) as `ft_noleggio_auto_importo_pagat`,
    sum(`ft_noleggio_auto`.`numero_clienti`) as `ft_noleggio_auto_numero_client`,
    sum(`ft_noleggio_auto`.`numero_noleggi`) as `ft_noleggio_auto_numero_nolegg`,
    avg(`ft_noleggio_auto`.`sconto_medio`) as `ft_noleggio_auto_sconto_medio`,
    count(distinct `ft_noleggio_auto`.`tasse_medie`) as `ft_noleggio_auto_importo_tasse`,
    count(*) as `ft_noleggio_auto_fact_count`
from
    `ft_noleggio_auto` as `ft_noleggio_auto`,
    `dt_automobile` as `dt_automobile`,
    `dt_citta` as `dt_citta_2`,
    `dt_autonoleggio` as `dt_autonoleggio`
where
    `ft_noleggio_auto`.`id_automobile` = `dt_automobile`.`id_automobile`
and
    `ft_noleggio_auto`.`id_autonoleggio` = `dt_autonoleggio`.`id_autonoleggio`
and
    `dt_autonoleggio`.`id_citta` = `dt_citta_2`.`id_citta`
group by
    `dt_automobile`.`modello`,
    `dt_citta_2`.`stato`;



