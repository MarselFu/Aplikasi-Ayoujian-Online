<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Soal_model extends CI_Model
{

    public function getDataSoal($id, $dosen)
    {
        $this->db->select('a.id_soal, a.soal, a.questions_used,a.is_active,FROM_UNIXTIME(a.created_on) as created_on, FROM_UNIXTIME(a.updated_on) as updated_on, b.nama_matkul, c.nama_dosen');
        $this->db->from('tb_soal a');
        $this->db->join('matkul b', 'b.id_matkul=a.matkul_id');
        $this->db->join('dosen c', 'c.id_dosen=a.dosen_id');
        if ($id !== null && $dosen === null) {
            $this->db->where('a.matkul_id', $id);
        } else if ($id !== null && $dosen !== null) {
            $this->db->where('a.dosen_id', $dosen);
        }
        return $this->db->get()->result();
    }

    public function getSoalById($id)
    {
        return $this->db->get_where('tb_soal', ['id_soal' => $id])->row();
    }

    public function getMatkulDosen($nip)
    {
        $this->db->select('matkul_id, nama_matkul, id_dosen, nama_dosen');
        $this->db->join('matkul', 'matkul_id=id_matkul');
        $this->db->from('dosen')->where('nip', $nip);
        return $this->db->get()->row();
    }

    public function getAllDosen()
    {
        $this->db->select('*');
        $this->db->from('dosen a');
        $this->db->join('matkul b', 'a.matkul_id=b.id_matkul');
        return $this->db->get()->result();
    }
    public function updateQuestionUsage($questionIds)
    {
        $this->db->where_in('id_soal', $questionIds);
        $this->db->set('questions_used', 'questions_used + 1', false);
        $this->db->update('tb_soal');
        return $this->db->affected_rows() > 0;
    }
}
